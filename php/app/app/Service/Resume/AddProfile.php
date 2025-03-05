<?php

namespace App\Service\Resume;

use App\Models\UserResume;
use Illuminate\Support\Facades\Auth;

class AddProfile
{
    /**
     * プロフィールの作成または更新を実行
     *
     * @param array $validatedData バリデーション済みのデータ
     * @return array 結果データ
     * @throws \Exception
     */
    public function execute(array $validatedData): array
    {
        $uniqueHash = $this->generateHash();

        if (UserResume::where('user_id', Auth::id())->exists()) {
            throw new \Exception('既にプロフィールが存在します。');
        }

        UserResume::updateOrCreate(
            ['user_id' => Auth::id()],
            [
                'name' => $validatedData['name'],
                'strengths' => $validatedData['strengths'],
                'hash' => $uniqueHash,
            ]
        );

        return [
            'hash' => $uniqueHash,
            'name' => $validatedData['name'],
            'strengths' => $validatedData['strengths'],
        ];
    }

    /**
     * ユニークハッシュを生成
     *
     * @return string
     */
    private function generateHash(): string
    {
        return hash('sha256', Auth::user()->email);
    }
}
