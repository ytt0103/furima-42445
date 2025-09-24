FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {'test@example'}
    password              {'123abc'}
    password_confirmation {password}
    last_name             {'佐藤'}
    first_name            {'太郎'}
    last_name_kana        {'サトウ'}
    first_name_kana       {'タロウ'}
    birth_date            {'2000-01-01'}
  end
end