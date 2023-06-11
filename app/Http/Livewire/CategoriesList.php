<?php

namespace App\Http\Livewire;

use App\Models\Category;
use Livewire\Component;
use Livewire\WithPagination;
use Illuminate\Support\Str;
use Illuminate\Support\Collection;

class CategoriesList extends Component
{
    use WithPagination;

    public Category $category;

    public bool $showModal = false;

    public array $active = [];

    public Collection $categories;

    public int $editedCategoryId = 0;

    public int $currentPage = 1;

    public int $perPage = 10;

    protected $listeners = ['delete'];

    //open modal
    public function openModal()
    {
        $this->showModal = true;
        $this->category = new Category();
    }

    //validation
    public function rules(): array
    {
        return [
            'category.name' => ['required', 'string', 'min:3'],
            'category.slug' => ['nullable', 'string'],
        ];
    }

    //slig genrate otomatis
    //Livewire Lifecycle Hooks
    public function updatedCategoryName()
    {
        $this->category->slug = Str::slug($this->category->name);
    }

    //save ke tabel
    public function save()
    {
        $this->validate();
        if ($this->editedCategoryId === 0) {
            $this->category->position = Category::max('position') + 1;
        }

        $this->category->save();
        $this->resetValidation();
        $this->reset('showModal', 'editedCategoryId');
    }

    //toogle
    public function toggleIsActive($categoryId)
    {
        Category::where('id', $categoryId)->update([
            'is_active' => $this->active[$categoryId],
        ]);
    }

    public function updateOrder($list)
    {
        foreach ($list as $item) {
            $cat = $this->categories->firstWhere('id', $item['value']);

            $order = $item['order'] + (($this->currentPage - 1) * $this->perPage);

            if ($cat['position'] != $order) {
                Category::where('id', $item['value'])->update(['position' => $order]);
            }
        }
    }

    //edit
    public function editCategory($categoryId)
    {
        $this->resetValidation();
        $this->editedCategoryId = $categoryId;
        $this->category = Category::find($categoryId);
    }

    //cancel category
    public function cancelCategoryEdit()
    {
        $this->resetValidation();
        $this->reset('editedCategoryId');
    }

    //delete confirmation
    public function deleteConfirm($method, $id = null)
    {
        $this->dispatchBrowserEvent('swal:confirm', [
            'type'   => 'warning',
            'title'  => 'Are you sure?',
            'text'   => '',
            'id'     => $id,
            'method' => $method,
        ]);
    }


    //delete data
    public function delete($id)
    {
        Category::findOrFail($id)->delete();
    }

    //render view blade
    public function render()
    {
        $cats = Category::orderBy('position')->paginate($this->perPage);

        $links = $cats->links();
        $this->currentPage = $cats->currentPage();

        $this->categories = collect($cats->items());

        $this->active = $this->categories->mapWithKeys(
            fn (Category $item) => [$item['id'] => (bool) $item['is_active']]
        )->toArray();

        return view('livewire.categories-list', [
            'links' => $links,
        ]);
    }
}
