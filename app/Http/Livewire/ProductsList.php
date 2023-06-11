<?php

namespace App\Http\Livewire;

use App\Models\Category;
use App\Models\Country;
use App\Models\Product;
use Livewire\Component;
use Livewire\WithPagination;
use Rap2hpoutre\FastExcel\FastExcel;

class ProductsList extends Component
{
    use WithPagination;
    public array $categories = [];
    public array $countries = [];
    public array $searchColumns = [
        'name' => '',
        'price' => ['', ''],
        'description' => '',
        'category_id' => 0,
        'country_id' => 0,
    ];

    //shortir
    public string $sortColumn = 'products.name';

    public string $sortDirection = 'asc';

    //penyortiran
    protected $queryString = [
        'sortColumn' => [
            'except' => 'products.name'
        ],
        'sortDirection' => [
            'except' => 'asc',
        ],
    ];

    //delete
    protected $listeners = ['delete', 'deleteSelected'];

    //delete multiple
    public array $selected = [];

    //pertama dijalankan
    public function mount(): void
    {
        $this->categories = Category::pluck('name', 'id')->toArray();
        $this->countries = Country::pluck('name', 'id')->toArray();

        //optional dari members
        $this->searchColumns["price"] = [0, Product::max('price') / 100];
    }

    public function getSelectedCountProperty(): int
    {
        return count($this->selected);
    }

    //short
    public function sortByColumn($column): void
    {
        if ($this->sortColumn == $column) {
            $this->sortDirection = $this->sortDirection == 'asc' ? 'desc' : 'asc';
        } else {
            $this->reset('sortDirection');
            $this->sortColumn = $column;
        }
    }

    //delete confirm
    public function deleteConfirm($method, $id = null): void
    {
        $this->dispatchBrowserEvent('swal:confirm', [
            'type'  => 'warning',
            'title' => 'Are you sure?',
            'text'  => '',
            'id'    => $id,
            'method' => $method,
        ]);
    }

    //delete
    public function delete($id): void
    {
        $product = Product::findOrFail($id);
        if ($product->orders()->exists()) {
            $this->addError('orderexist', 'This product cannot be deleted, it already has orders');
            return;
        }

        $product->delete();
    }

    //delete selected
    public function deleteSelected(): void
    {
        $products = Product::with('orders')->whereIn('id', $this->selected)->get();

        foreach ($products as $product) {
            if ($product->orders()->exists()) {
                $this->addError("orderexist", "Product <span class='font-bold'>{$product->name}</span> cannot be deleted, it already has orders");
                return;
            }
        }

        $products->each->delete();
        $this->reset('selected');
    }

    //export
    public function export()
    {
        // abort_if(! in_array($format, ['csv', 'xlsx', 'pdf']), Response::HTTP_NOT_FOUND);
        // return Excel::download(new ProductsExport($this->selected), 'products.' . $format);

        return (new FastExcel(Product::all()))->download('file_products.xlsx');
    }


    //render component blade
    public function render()
    {
        //optional dari members
        $products = Product::query()
            ->select(['products.*', 'countries.id as countryId', 'countries.name as countryName',])
            ->join('countries', 'countries.id', '=', 'products.country_id')
            ->whereBetween(
                'products.price',
                [
                    floatval($this->searchColumns['price'][0]) * 100,
                    floatval($this->searchColumns['price'][1]) * 100
                ]
            )
            ->with('categories')
            ->where('products.name', 'LIKE', '%' . $this->searchColumns['name'] . '%')
            ->where('products.description', 'LIKE', '%' . $this->searchColumns['description'] . '%')
            ->when($this->searchColumns['category_id'], function ($query) {
                $query->whereRelation('categories', 'id', $this->searchColumns['category_id']);
            })
            ->when($this->searchColumns['country_id'], function ($query) {
                $query->whereRelation('country', 'id', $this->searchColumns['country_id']);
            });

        // $products = Product::query()
        //     ->select(['products.*', 'countries.id as countryId', 'countries.name as countryName',])
        //     ->join('countries', 'countries.id', '=', 'products.country_id')
        //     ->with('categories');

        // foreach ($this->searchColumns as $column => $value) {
        //     if (!empty($value)) {
        //         $products->when($column == 'price', function ($products) use ($value) {
        //             if (is_numeric($value[0])) {
        //                 $products->where('products.price', '>=', $value[0] * 100);
        //             }
        //             if (is_numeric($value[1])) {
        //                 $products->where('products.price', '<=', $value[1] * 100);
        //             }
        //         })
        //             ->when($column == 'category_id', fn ($products) => $products->whereRelation('categories', 'id', $value))
        //             ->when($column == 'country_id', fn ($products) => $products->whereRelation('country', 'id', $value))
        //             ->when($column == 'name', fn ($products) => $products->where('products.' . $column, 'LIKE', '%' . $value . '%'));
        //     }
        $products->orderBy($this->sortColumn, $this->sortDirection);

        return view('livewire.products-list', [
            'products' => $products->paginate(5),
        ]);
    }
}
