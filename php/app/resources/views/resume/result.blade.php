<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('プロフィールの入力結果') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg p-6">
                <h3 class="text-lg font-bold text-gray-900 dark:text-gray-100">
                    {{ __('以下の内容が送信されました') }}
                </h3>

                {{-- 入力された情報 --}}
                <div class="mt-4 text-gray-700 dark:text-gray-300">
                    <p><strong>{{ __('お名前') }}:</strong> {{ $name }}</p>
                    <p><strong>{{ __('自己PR、志望動機の要素') }}:</strong></p>
                    <p class="whitespace-pre-wrap">{{ $strengths }}</p>
                </div>

                {{-- 生成されたユニークハッシュ --}}
                <div class="mt-6">
                    <h4 class="text-md font-semibold text-gray-800 dark:text-gray-200">
                        {{ __('このプロファイルのユニークハッシュ値') }}
                    </h4>
                    <p class="text-blue-600 dark:text-blue-400">{{ $hash }}</p>
                </div>

                {{-- 戻るボタン --}}
                <div class="mt-6">
                    <a href="{{ route('resume') }}"
                       class="inline-flex items-center px-4 py-2 bg-blue-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 active:bg-blue-600">
                        {{ __('戻る') }}
                    </a>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>
