<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Providers\RouteServiceProvider;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Laravel\Socialite\Facades\Socialite;
use Illuminate\Support\Str;

class SocialiteController extends Controller
{
    //login social
    public function loginSocial(Request $request, string $provider): RedirectResponse
    {
        $this->validateProvider($request);
        return Socialite::driver($provider)->redirect();
    }

    //callback
    public function callbackSocial(Request $request, string $provider)
    {
        $this->validateProvider($request);

        $response = Socialite::driver($provider)->user();

        $user = User::firstOrCreate(
            ['email' => $response->getEmail()],
            ['password' => Str::password()]
        );
        $data = [$provider . '_id' => $response->getId()];
        if ($user->wasRecentlyCreated) {
            $data['name'] = $response->getName() ?? $response->getNickname();
            event(new Registered($user));
        }

        $user->update($data);

        Auth::login($user, remember: true);
        return redirect()->intended(RouteServiceProvider::HOME);
    }

    //saran orang lain
    // public function callbackSocial2(Request $request, string $provider): RedirectResponse
    // {
    //     $this->validateProvider($request);

    //     $response = Socialite::driver($provider)->user();

    //     $user = User::updateOrCreate(
    //         ['email' => $response->getEmail()],
    //         [
    //             'password' => Str::password(),
    //             'name' => $response->getName() ?? $response->getNickname,
    //             $provider . '_id' => $response->getId()
    //         ]
    //     );

    //     if ($user->wasRecentlyCreated) {
    //         event(new Registered($user));
    //     }

    //     Auth::login($user, remember: true);

    //     return redirect()->intended(RouteServiceProvider::HOME);
    // }


    //validated
    protected function validateProvider(Request $request): array
    {
        return $this->getValidationFactory()->make(
            $request->route()->parameters(),
            ['provider' => 'in:facebook,google,github']
        )->validate();
    }
}
