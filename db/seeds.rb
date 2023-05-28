include FactoryBot::Syntax::Methods

user = FactoryBot.create(:user)
article = FactoryBot.create(:article,user: user )
FactoryBot.create(:comment, user: user, article: article )
FactoryBot.create(:social_profile, user: user)
