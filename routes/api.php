<?php

use App\Http\Controllers\Api\V1\Auth\LoginController;
use App\Http\Controllers\Api\V1\Auth\LogoutController;
use App\Http\Controllers\Api\V1\Auth\PasswordUpdateController;
use App\Http\Controllers\Api\V1\Auth\ProfileController;
use App\Http\Controllers\Api\V1\Auth\RegisterController;
use App\Http\Controllers\Api\V1\ParkingController;
use App\Http\Controllers\Api\V1\VehicleController;
use App\Http\Controllers\Api\V1\ZoneController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

//http://livewire-order.test/api/v1/auth/register
Route::post('auth/register', RegisterController::class);

//http://livewire-order.test/api/v1/auth/login
Route::post('auth/login', LoginController::class);

//middleware
Route::middleware('auth:sanctum')->group(function () {

    //profile users
    Route::get('profile', [ProfileController::class, 'show']);
    Route::put('profile', [ProfileController::class, 'update']);

    //auth
    Route::put('password', PasswordUpdateController::class);
    Route::post('auth/logout', LogoutController::class);

    //kendaraan mobil/motor
    Route::apiResource('vehicles', VehicleController::class);

    //zona parkir
    Route::get('zones', [ZoneController::class, 'index']);

    //parkir
    Route::post('parkings/start', [ParkingController::class, 'start']);

    //dari pivolas
    // Route::get('parkings/{parking}', [ParkingController::class, 'show']);
    // Route::put('parkings/{parking}', [ParkingController::class, 'stop']);

    //saran member
    Route::get('parkings/{parking}', [ParkingController::class, 'show'])->whereNumber('parking');
    Route::put('parkings/{parking}', [ParkingController::class, 'stop'])->whereNumber('parking');
});
