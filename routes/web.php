<?php

use App\Http\Controllers\Admin\TestController;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ResultController;
use App\Http\Livewire\CategoriesList;
use App\Http\Livewire\Front\Leaderboard;
use App\Http\Livewire\OrderForm;
use App\Http\Livewire\OrdersList;
use App\Http\Livewire\ProductForm;
use App\Http\Livewire\ProductsList;
use App\Http\Livewire\Questions\QuestionForm;
use App\Http\Livewire\Questions\QuestionList;
use App\Http\Livewire\Quiz\QuizForm;
use App\Http\Livewire\Quiz\QuizList;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

//public quiz
Route::get('/', [HomeController::class, 'index'])->name('home');
Route::get('quiz/{quiz}/{slug?}', [HomeController::class, 'show'])->name('quiz.show');
Route::get('results/{test}', [ResultController::class, 'show'])->name('results.show');
Route::get('leaderboard', Leaderboard::class)->name('leaderboard');

// auth
Route::middleware('auth')->group(function () {
    Route::get('results', [ResultController::class, 'index'])->name('results.index');

    //laravel controller
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    //admin
    Route::middleware('isAdmin')->group(function () {
        //pertanyaan
        Route::get('questions', QuestionList::class)->name('questions');
        Route::get('questions/create', QuestionForm::class)->name('questions.create');
        Route::get('questions/{question}', QuestionForm::class)->name('questions.edit');

        //quiz crud
        Route::get('quizzes', QuizList::class)->name('quizzes');
        Route::get('quizzes/create', QuizForm::class)->name('quiz.create');
        Route::get('quizzes/{quiz}', QuizForm::class)->name('quiz.edit');

        //list test
        Route::get('tests', TestController::class)->name('tests');
    });

    //livewire controller
    Route::get('categories', CategoriesList::class)->name('categories.index');
    Route::get('products', ProductsList::class)->name('products.index');
    Route::get('products/create', ProductForm::class)->name('products.create');
    Route::get('products/{product}', ProductForm::class)->name('products.edit');

    //order
    Route::get('orders', OrdersList::class)->name('orders.index');
    Route::get('orders/create', OrderForm::class)->name('orders.create');
    Route::get('orders/{order}', OrderForm::class)->name('orders.edit');
});

require __DIR__ . '/auth.php';
