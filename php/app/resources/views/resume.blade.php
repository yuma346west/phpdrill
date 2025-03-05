<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 dark:text-gray-200 leading-tight">
            {{ __('プロフィール入力') }}
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">

            <div class="bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg p-6">
                @if(isset($existingResume) && $existingResume)
                    <div class="mb-6 p-4 bg-yellow-50 border-yellow-400 text-yellow-700">
                        <p>{{ __('登録済みのデータがあります') }}</p>
                        <a href="{{ route('resume.result') }}" class="text-blue-600 hover:underline">
                            {{ __('> 登録内容を確認する') }}
                        </a>
                    </div>
                @endif
            </div>

            <div class="mt-6 bg-white dark:bg-gray-800 overflow-hidden shadow-sm sm:rounded-lg p-6">
                <form method="POST" action="/resume" class="space-y-6">
                    @csrf

                    {{-- 名前 --}}
                    <div class="space-y-1">
                        <label for="name" class="block text-sm font-medium text-gray-700">
                            {{ __('お名前') }}
                        </label>
                        <input type="text" id="name" name="name"
                               value="{{ old('name', $userName ?? '') }}"
                               class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
                               required>
                        @error('name')
                        <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                        @enderror
                    </div>

                    {{-- 自己PRの強み --}}
                    <div class="space-y-1">
                        <label for="strengths" class="block text-sm font-medium text-gray-700">
                            {{ __('自己PR、志望動機の要素') }}
                        </label>
                        <textarea id="strengths" name="strengths" rows="4"
                                  class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
                                  placeholder="{{ __('志望動機や自己PRに使いたい要素を書いてください') }}" required></textarea>
                        @error('strengths')
                        <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                        @enderror
                    </div>

                    {{-- 提出ボタン --}}
                    <div class="mt-4">
                        <button type="submit"
                                class="inline-flex justify-center py-2 px-4 border border-gray-400 text-sm font-medium rounded-md text-gray-800 bg-blue-600 hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 disabled:opacity-50 disabled:cursor-not-allowed"
                                @if ($errors->any()) disabled @endif>
                            {{ __('提出する') }}
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</x-app-layout>
