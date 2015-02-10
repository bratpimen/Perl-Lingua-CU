# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Lingua-CU.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use strict;
use warnings;
use utf8;

use Test::More tests => 11;
BEGIN { use_ok('Lingua::CU', qw(cyrillicToArabic arabicToCyrillic resolve cu2ru)); use_ok('Lingua::CU::Collate', '1.04'); };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.
# set up UTF8 crap
 my $builder = Test::More->builder;
    binmode $builder->output,         ":utf8";
    binmode $builder->failure_output, ":utf8";
    binmode $builder->todo_output,    ":utf8";

# test if numeral conversion is sane
my @input;
my @output;
for (my $i = 0; $i < 1000; $i++) {
	# generate random number between 1 and 9999
	push (@input, int(rand(9998)) + 1);
	push (@output, cyrillicToArabic(arabicToCyrillic($input[$i])));
}

is_deeply (\@output, \@input, "Numeral conversion is sane");
diag("Numeral conversion is sane");
# test if Titlo resolution works fine
is (resolve ("ст҃ъ"), "свѧ́тъ", "Titlo resolution works");
diag("Titlo resolution works");
# test if Slavonic can be converted to Russian
is (cu2ru ("ст҃ъ"), "свя́тъ", "Slavonic to Russian conversion works");
diag("Slavonic to Russian conversion works");
is (cu2ru ("ст҃ъ", { noaccents => 1 }), "святъ", "noaccents option is honored");
diag("noaccents option is honored");
is (cu2ru ("ст҃ъ", { noaccents => 1, modernrules => 1 }), "свят", "modernrules option is honored");
diag("modernrules option is honored");

# test if collation works
use List::Util 'shuffle';
my $Collator = Lingua::CU::Collate->new (   normalization => undef  );
is(ref $Collator, "Unicode::Collate", "Unicode::Collate is accessible");
diag("Unicode::Collate is accessible");

#ok($Collator->cmp("", ""), "Unicode::Collate is sane");
ok($Collator->eq("", ""), "Unicode::Collate is not crazy");
diag("Unicode::Collate is not crazy");
ok($Collator->cmp("", "perl"), "Unicode::Collate accepts Unicode");
diag("Unicode::Collate accepts Unicode");
my @words = <DATA>;
@output = $Collator->sort(shuffle @words);
is_deeply (\@output, \@words, "Church Slavonic collation works");
diag("Church Slavonic collation works");

__DATA__
а҆
а҆ввакꙋ́ме
а҆вїда̀
а҆́гг҃лы
а҆́гг҃льскагѡ
а҆́гница
а҆́гнца
а҆́зъ
а҆кѵ́лѣ
а҆ллилꙋ́їа
а҆мали́къ
а҆нало́гїи
а҆по́столъ
а҆прі́лїа
а҆прі́ллїа
а҆пⷭ҇ла
а҆пⷭ҇ли
а҆пⷭ҇лъ
а҆рме́нїи
а҆рхїдїа́кона
а҆рхїере́є
а҆́ще
а҆ѵѯе́нтїа
бг҃а
бг҃обл҃же́нне
бг҃оневѣ́стнаѧ
бг҃оневѣ́сто
бг҃ороди́тельнице
бг҃оро́диченъ
бг҃осажде́ннѣи
бг҃очести̑вымъ
бг҃ꙋ
бг҃ъ
бцⷣе
бцⷣы
бдѣ́нїихъ
безбо́жнагѡ
безбо́жныхъ
бе́зднѣ
беззако́нїю
безма́тернѧго
безмо́лвїе
безневѣ́стнаѧ
безпло́тныхъ
безсме́ртенъ
безче́стїѧ
бж҃е
бж҃е́ственными
бж҃їе
бж҃їей
бж҃їй
бж҃їю
бж҃їѧ
бжⷭ҇тва̀
бжⷭ҇твенными
блага́гѡ
благодарю́
благодѣ́тельствꙋетсѧ
благохвале́нїе
благоче́стнѡ
благочестномꙋ́дреннѡ
бла́гъ
блаже́ннѣе
бл҃га́ѧ
бл҃года́ти
бл҃года́ть
бл҃гомо́щнꙋю
бл҃горо́днѣйшею
бл҃гослове́ннаѧ
бл҃гослове́нъ
бл҃гъ
бл҃жє́нна
бл҃же́нне
бл҃же́нъ
бл҃жи́тъ
блꙋдни́цы
бо
богати́тъ
болѣ́зней
бра́тїй
брѧца́ющаѧ
бꙋ́дета
бꙋ́дете
бꙋ́дꙋтъ
бꙋ́дꙋщемъ
быва́етъ
бы́вшыѧ
бы́въ
бы́лъ
бы́сте
бы́сть
бы́ти
бѣ́
бѣ̀
бѣжи́тъ
бѣсо́вскими
бѣсѡ́вскїѧ
вавѵ́ло
ва̑рварскаѧ
ва́съ
ва́ши
вда́стъ
вели́кїй
вели́кїѧ
вели́кое
вели́цѣй
велича́емъ
вели̑чїѧ
ве́рзисѧ
весе́лїемъ
весе́лїѧ
веселѧ́тсѧ
ве́сь
ве́чера
вече́рни
вечє́рнїѧ
взыва́емъ
взыгра́имъ
взы́де
взыска́ти
взѧ̀
ви́дите
ви́диши
ви́дѣвшыѧ
ви́дѣти
вино́вное
вино́вныѧ
виѳлее́ме
влⷣка
влⷣки
влⷣко
влⷣчце
влѣ́зе
вмѣ́стѡ
внегда̀
внꙋ́трєннѧѧ
внꙋ́трь
во
во́ды
водѣ̀
возвы́шена
воздадѐ
воздви́гъ
воздержа́нїемъ
воздержа́нїѧ
воздꙋ́хъ
возлага́етъ
возложѝ
возложи́всѧ
возло́жше
возлюбле́нїемъ
возлю́бленнаго
возлю́блєнныѧ
во́змете
возмни́тъ
возмѡ́жна
возмꙋжа́юсѧ
вознесо́стесѧ
возопи́хъ
возопі́й
возраста́етъ
возсїѧ̀
возсыла́емъ
во́ина
во́инства
вои́стинꙋ
во́лею
вѡ́льнаѧ
во́льнѡ
вопїе́тъ
воплоти́вшагосѧ
воплоти́сѧ
воскре́сенъ
воскре́сны
воскре́съ
воскрⷭ҇нїѧ
воскрⷭ҇нъ
воскрⷭ҇ны
вослѣ́дованїе
воспита́вшее
воспои́мъ
воспрїимѝ
воспрїѧ́лъ
воспѣва́шесѧ
воспѣ́ти
востаѧ̀
восхвалѧ́юще
восхо́дитъ
восхо́домъ
восхожде́нїѧ
врага̀
врагѡ́въ
врачꙋ́ющїѧ
вре́мѧ
всѐ
всебога́те
всеви́дца
всегда̀
всего̀
вселе́ннаѧ
всели́тисѧ
всемі́рнꙋю
всенепоро́чнаѧ
всепѣ́таѧ
всесожже́нїе
всест҃а́ѧ
всесщ҃е́нное
всечтⷭ҇но́е
всеще́дре
всѝ
вскꙋ́ю
всѣ́ми
всѣ̑мъ
всѣ́хъ
всю̀
всѧ̀
всѧ̑
всѧ́кагѡ
всѧ́кїй
всѧ́кое
всѧ́комъ
всѧ́чєскаѧ
вхо́дѧтъ
вхожда́ше
въ
вы́нꙋ
высотѣ̀
высо́цѣ
вы́шнихъ
вы́шше
вѣ́дꙋщихъ
вѣ́ки
вѣкѡ́въ
вѣ́къ
вѣ́мы
вѣнча́вшемꙋ
вѣ́рнїи
вѣ̑рныѧ
вѣ́рою
вѣ́рꙋ
вѣ́сть
вѣ́чнꙋющагѡ
глава̀
главы̀
глаго́ла
глаго́лемъ
глаго́летсѧ
глаго́летъ
глаго́лю
глаго́люща
глаго́лѧ
гла́са
гла́съ
гл҃го́лы
глꙋбинѣ̀
гнѣ́ваютсѧ
гѡ
гони́тель
гора̀
го́рдагѡ
го́рести
горѧ́щꙋю
гра́дъ
гра́дѣ
гре́ч
грѣха̀
грѣхѡ́въ
грѣ́шнїи
грѧде́тъ
гдⷭ҇а
гдⷭ҇ень
гдⷭ҇и
гдⷭ҇ни
гдⷭ҇нима
гдⷭ҇ню
гдⷭ҇нѧ
гдⷭ҇ꙋ
гдⷭ҇ь
да
да́вшаѧ
даде́
далі́да
да́мъ
да́ромъ
да́ръ
да́ти
два̀
дв҃дова
дв҃дъ
дв҃о
дв҃ы
де́нь
дерзнове́нїемъ
диви́тсѧ
д҃і
дїа́конъ
ді́скосъ
днѐ
дне́сь
до
до́блественнѣйше
до́блїи
до́блѧ
до́браѧ
дѡ́браѧ
до́брое
довлѣ́етъ
догма́тїкъ
догма́ты
дожди́тъ
дои́ши
долгѡ́въ
долгота́
долготерпѣли́ве
домꙋ̀
дре́вле
дре́во
дрꙋ́гъ
дрꙋгъдрꙋ́га
дꙋ́ха
дꙋ́хи
дꙋ́хъ
дꙋшѝ
дꙋ́шъ
дꙋ́шы
дх҃а
дыха́нїе
дѣ́йствоватисѧ
дѣ́лателѧ
дѣѧ́нїємъ
дѣѧ́нїй
дѣѧ̑нїѧ
є
є҃
є҆гда̀
є҆го̀
є҆гѡ̀
є҆го́же
є҆гѡ́же
є҆да̀
є҆де́мѣ
є҆ди́но
є҆ди́номꙋ
є҆диносꙋ́щнѣй
є҆ди́нꙋ
є҆ди́нъ
є҆́же
є҃і
є҆ктєнїѝ
є҆ле́й
є҆лїссе́ю
є҆́ллинѡмъ
є҆мꙋ̀
є҆ресе́й
є҆сѝ
є҆́смь
є҆́сть
є҆ще́
є҆ѯапостїла́рїй
є҆ѵⷢ҇лїе
є҆ѵфросѵ́нїе
же
жела́нїе
жела́нїѧ
жена̀
жена́ми
женѣ̀
жє́ртвы
живота̀
живѡ́тнымъ
животꙋ̀
жили́ще
жите́йскїѧ
житїю̀
ѕла̀
ѕло́бою
ѕлочести́выхъ
ѕлы́хъ
ѕлы̑ѧ
ѕмі́ѧ
ѕѡ́лъ
ѕѣлѡ̀
за
зако́номъ
заповѣ́дахъ
за́повѣдехъ
запретѝ
зарѧ́ми
застꙋпа́ющагѡ
затворє́на
затвори́лъ
заха́рїи
зача́ло
землѝ
зе́млю
землѧ̀
земно́е
земны́й
земны́хъ
земны̑ѧ
з҃і
златослове́снаго
зна́ли
зна́менасѧ
зовꙋ́ще
зовꙋ́щи
зрѝ
зрѣ́нїе
зрѣ́нїемъ
зрѧ́ще
зрѧ́щꙋ
и҆
й
и҆гра́ѧ
и҆́же
и҆зба́ви
и҆зба́витель
и҆зба́вителѧ
и҆зба́витисѧ
и҆зба́вльшемꙋ
и҆зведе́тъ
и҆зведѝ
и҆зво́ли
и҆згонѧ̀
и҆зсо́хшей
и҆зстꙋпле́нїи
и҆зсꙋши́лъ
и҆з̾
и҆лѝ
и҆́мамы
и҆́мене
и҆́мⷬ҇къ
и҆̀мъ
и҆мѣ́ла
и҆мѣ́ѧ
и҆́мѧ
и҆на́гѡ
и҆ногда̀
и҆́ноки
и҆́нъ
и҆са́їа
и҆са́їю
и҆скоренѧ́юща
и҆скꙋ́снаго
и҆сповѣ́дахъ
и҆спо́лнисѧ
и҆спо́лнитель
и҆сполнѧ́ющи
и҆справле́нїй
и҆спросѝ
и҆спроси́ти
и҆спыта́нїѧ
и҆стлѣ́нїѧ
и҆сточе́нїе
и҆схо́дитъ
и҆схо́дъ
и҆сцѣле́нїе
и҆сцѣлѝ
и҆счита́етсѧ
и҆́хже
и҆́хъ
и҆̀хъ
і҃
і҆а́кѡве
і҆еровоа́мꙋ
і҆и҃левыхъ
і҆и҃се
і҆и҃совъ
і҆и҃сѣ
і҆ѡа́нна
і҆ѡа́нне
і҆ѻрда́на
і҆ѡ́сифово
і҆рмо́съ
і҆ꙋ́лїа
і҆ꙋ́нїа
канѡ́нъ
капернаꙋ́мъ
капі́тѡне
каса́тисѧ
каса́ющесѧ
ква́са
клеветы̀
клеврє́тъ
кн҃зе́й
кнѧ̑зи
ко
когда́либо
комм
конда́къ
коне́цъ
конє́цъ
концы̀
кончи́нꙋ
кра́ю
крестоноше́нїемъ
крове́й
кро́вомъ
крⷭ҇ти́въ
крⷭ҇топокло́ннꙋю
крꙋ́га
крѣ́пкагѡ
крѣ́постїю
крѣ́пость
крѣ́пцыи
ктомꙋ̀
къ
ла́зарѧ
лежа́ло
ле́сти
ли̑ки
ликꙋ́имъ
ли́къ
ли́ствїемъ
ли́шше
лїтꙋргі́и
ложесна̀
лозы̀
лꙋка̀
лꙋкѝ
лꙋко̀
лꙋче́ю
лѣ̑та
любвѝ
любе́знѡ
лю́бечскою
любо́вїю
любомꙋ́дрїе
лю́ди
лю́дїе
людьмѝ
лю́тыхъ
македо́нїй
мамфі́мъ
марі́ю
ма́ркѣ
ма́рта
ма́сти
ма́тери
ма́терни
менѐ
ми
мѝ
ми́ловатисѧ
милосе́рдъ
ми́лѡсти
ми́лостивнымъ
мине́и
ми́ромъ
ми́ръ
ми́рѣ
мі́рꙋ
мі́рѣ
мїхаи́ле
млⷭ҇ть
мл҃твами
мно́гими
мно́гѡ
многоми́лостиваго
многоѡбра́зныхъ
многоцѣ́ннаѧ
мнѡ́жества
мно́жество
моѐ
мое́й
моеѧ̀
мо́й
мои́мъ
моли́сѧ
моли́тва
моли́твенными
моли́твѣ
моли́те
молю́сѧ
молѧ́сѧ
мо́лѧтсѧ
молѧ́ще
молѧ́щи
мона́ха
мо́ре
мо́щно
мою̀
моѧ̀
моѧ̑
мѡѷсе́ови
мѡѷсе́ю
мра́къ
мра́цѣ
мт҃ри
мт҃рнее
мꙋ́жески
мꙋ́жъ
мꙋ́жы
мꙋче́нїѧ
мꙋчи́телємъ
мч҃нка
мч҃нцы
мыта̑рства
мѣ́сѧца
мѧ
мѧ̀
на
наведѐ
наде́жда
на́мъ
напа́стей
напа́сти
написа́тисѧ
напо́й
напредѝ
наслѣ́дїѧ
наслѣ́дꙋемъ
наставлѧ́юще
настоѧ́щїй
на́съ
наꙋчи́всѧ
наꙋчи́вшаѧ
наꙋчи́ти
находѧ́щихъ
нача́льникѡмъ
наче́ншїй
на́шегѡ
на́шей
на́шихъ
на́шъ
на́шымъ
на́шѧ
нб҃са̀
нб҃сѐ
нб҃снагѡ
нбⷭ҇ныхъ
не
небеса̀
невече́рнїй
нево́льнагѡ
недꙋ́га
недꙋ́ги
недꙋ́говавъ
недѣ́лю
незаходѧ́щее
не́й
неизмѣ́нно
неизрече́ннѡ
неизрече́ннꙋю
неискꙋсобра́чнаѧ
неистощи́мое
не́мже
неможе́нїѧ
не́мощехъ
немощны́хъ
немꙋ̀
ненаказа́нїе
неѡпали́маѧ
непло́ды
непоколеби́мое
непокори́выхъ
непоро́чнїи
непра́веднѡ
непрекло́ннїи
непреста́нный
нерꙋкосѣ́чный
несто́рїа
нетлѣ́нїемъ
нетлѣ́ннаѧ
нетлѣ́нный
нечести́вымъ
нечи́стъ
ни
нижѐ
низлага́ете
низложє́нныѧ
никогда́же
никогѡ́же
ни́мъ
ни̑мъ
ничто́же
нїкола́ю
но
нѡ́еви
носи́вшїй
носѧ̀
но́щи
нꙋжда́ющымсѧ
нꙋ́жды
ны̀
ны́нѣ
нѣ́дрѣхъ
нѣ́сте
нѣ́сть
нѧ̀
ѡ҆
ѽ
ѻ҆ба́че
ѻ҆би́тель
ѡ҆богати́тели
ѡ҆божи́вша
ѻ҆́бразомъ
ѡ҆бразꙋ́етъ
ѡ҆брати́сѧ
ѡ҆брѣ́лъ
ѡ҆брѣ́те
ѻ҆́бща
ѻ҆́бщагѡ
ѻ҆бще́нїе
ѻ҆́бщихъ
ѡ҆б̾
ѡ҆бѣ́сихомъ
ѡ҆бѣ́ты
ѡ҆бѣща́етъ
ѻ҆́гненнꙋю
ѻ҆́гнь
ѡ҆держа́щее
ѡ҆держи́мь
ѻ҆дїги́трїе
ѻ҃є
ѡ҆ѕлобле́нїе
ѻ҆́ко
ѡ҆крє́стнымъ
ѡ҆мы́етъ
ѻ҆нѝ
ѻ҆́ноѧ
ѻ҆́нъ
ѡ҆печалѧ́тисѧ
ѡ҆полчи́сѧ
ѡ҆правди́тсѧ
ѡ҆свѧща́етъ
ѻ҆смо́мъ
ѡ҆снова́вый
ѡ҆ста́вити
ѿ
ѿврати́тъ
ѻ҆те́цъ
ѻ҆тє́цъ
ѿи́де
ѿи́детъ
ѿню́дꙋже
ѿпꙋ́стъ
ѿрещи́сѧ
ѻ҆трокови́це
ѻ҆́троцы
ѻ҆троча̀
ѿтрѧ́съ
ѻ҆тцє́въ
ѻ҆тцы̀
ѻ҆ц҃а̀
ѻ҆ц҃ꙋ̀
ѻ҆́ч҃е
ѻ҆́ч҃ее
ѻ҆чи́ма
ѡ҆чисти́лище
ѡ҆чи́стишисѧ
ѡ҆чища́ете
ѡ҆чище́нїе
паде́нїю
па́ки
па́мѧти
па́мѧть
па́стырїе
па́стырю
па́схꙋ
патрїа́рсѣхъ
патрїа́рхова
па́че
па́ѵловнѣ
первозда́ннагѡ
пе́рстомъ
пещѝ
пе́щь
пи́саны
питі́й
пла́менемъ
пла́мень
плащани́цею
пло́дъ
пло́ти
пло́тїю
плѣ́нника
по
повелѣва́етъ
повелѣ́нїе
повече́рїи
повинꙋ́ющѧсѧ
повѣ́даемъ
погреба́етъ
пода́ждь
пода́ти
подвигополо́жника
по́двигъ
подоба́етъ
подо́бенъ
подо́бѧсѧ
пое́мъ
пое́тсѧ
пожи́лъ
по́жнетъ
по́йте
показа̀
показа́ти
показꙋ́ютъ
покаѧ́нїе
покланѧ́тисѧ
поклоне́нїе
покло́ны
поко́ѧ
покро́ва
по́лчище
по́лѧ
поми́ловатисѧ
поми́лꙋй
помина́й
помоли́всѧ
помоли́сѧ
помоли́тесѧ
помѧнꙋ́ти
поно́сѧтъ
поѻстри́тъ
посе́мъ
посла̀
посла́вый
посла́лъ
послꙋжи́стѣ
послꙋжи́ша
послꙋ́шайте
послꙋша́нїе
послѣ́дꙋюще
поста̀
поста́вѧтсѧ
по́стникѡвъ
пострада̀
поте́клъ
пото́ки
потоплѧ́ема
потре́бꙋ
похвалѧ́еми
почерпи́те
почто̀
пою́щыѧ
пра́вдꙋ
пра́веднаго
правосла́вныхъ
пра̑вымъ
пра́здна
пра́здника
првⷣный
прⷣте́ча
прⷣте́че
пребж҃е́ственный
превели́кое
превозни́кнетъ
превозно́симъ
прегрѣше́нїй
прегрѣши́вшихъ
предадѐ
преди́вный
предо
предста́ти
предстоѧ́тъ
предстоѧ́ще
пред̾
предъ
пред̾ꙋспѣ́ти
пред̾ꙋстро́итисѧ
предѣ́лехъ
пре́жде
пре́лести
премꙋ́дрость
премѣнѧ́ѧ
преподо́бныхъ
препоѧ́сашасѧ
препѣ́таѧ
пресвѣ́тлымъ
пресе́льника
пресла̑внаѧ
пресла́вное
преслꙋша́нїѧ
преставле́нїе
престꙋпле́нїемъ
претво́рсѧ
пречи́стꙋю
пречⷭ҇таѧ
приближа́ющесѧ
призва́вше
призыва́ти
призыва́хꙋ
приключе́нїи
прилѡ́гъ
приложѝ
прилꙋчи́вшїйсѧ
прилѣ́жнѡ
прилѣ̑жныѧ
припѣ́вы
присносꙋ́щныѧ
приснотекꙋ́щемꙋ
прише́ствїе
пришла̀
прїединѝ
прїе́млетъ
прїе́млѧ
прїиди́те
прїимѝ
прїимꙋ̀
прїитѝ
прїѡбрѣ́лъ
прїѧ́ла
прїѧ́лъ
прїѧ́ти
прїѧ́хомъ
прогнѣ́вавшихъ
прозѧ́бшїй
произволе́нїе
прокі́менъ
прⷪ҇ро́ка
прⷪ҇ро́чествꙋете
просвѣти́
просвѣтѝ
просвѣти́вшисѧ
просвѣтлѣ́нїе
просвѣ́щшисѧ
просла́вимъ
просла́висѧ
просла́вльши
просте́ръ
противлє́нїѧ
проше́дшемꙋ
прпⷣбна
прпⷣбнагѡ
прпⷣбне
прпⷣбнымъ
прпⷣбныѧ
прⷭ҇то́ла
прⷭ҇то́лѣ
прчⷭ҇тое
прѧ́мѡ
пꙋтѝ
пꙋти̑
пꙋщени́цею
пѣ́снь
пѣ́сньми
пѣ́ти
пѧткꙋ̀
рабѡ́мъ
рабѡ́тнымъ
ра́бъ
ра̑бъ
ра́ди
ра́достїю
ра́дость
ра́дꙋйсѧ
ра́дꙋйтесѧ
ра́дꙋютсѧ
ра́дꙋющесѧ
разбо́йники
раздѣли́въ
раздѣлѧ́етсѧ
разжже́гсѧ
различноѡбра́зное
разстоѧ́щаѧсѧ
ра́мꙋ
распина́ема
расторга́ютсѧ
расточѝ
ра́тникѡмъ
рве́нїемъ
ревнова́ти
реко́ста
речѐ
рече́мъ
ри̑зы
родила̀
роди́лсѧ
роди́тисѧ
ро́дъ
рожде́нїѧ
рожде́ннаго
ро́сꙋ
рꙋкꙋ̀
рꙋ́сскагѡ
рꙋ́цѣ
ры́бы
рѣ́етъ
рѧдꙋ̀
с
савва́тїа
самогла́сенъ
самꙋ́илꙋ
са́мъ
сапфі́ра
своего̀
своегѡ̀
своемꙋ̀
свое́мъ
свои́мъ
свою̀
своѧ̑
свы́ше
свѣ́та
свѣ́те
свѣ́тлаѧ
свѣтлѣ́йши
свѣтово́дитсѧ
свѣтода́вче
свѣтоза́рнѡ
свѣтоѡбра̑знаѧ
свѣ́тъ
свѧ́та
свѧще́нникъ
свѧще́нницы
свѧщенномꙋ́ченикъ
сѐ
себѐ
себѣ̀
сего̀
сегѡ̀
се́дмьдесѧтъ
селе́нїе
селє́нїѧ
семе́йство
семꙋ́
септе́мврїа
се́рдца
сердца́мъ
си́ла
си́лами
си́лою
си́лꙋ
си́рѣчь
си́хъ
сїѐ
сі́мѡнъ
сїѡ́не
сїѡ́нѣ
сїѧ̑
сїѧ́ющее
сказа́нїй
ски́нїе
скѡ́рби
ско́рѡ
скѡ́тна
сла́ва
сла́вимъ
сла́вити
сла́вныхъ
сла́вы
сла̑сти
сле́зъ
слезѧ́щи
сло́ва
слове́снагѡ
словесы̀
сло́во
сло́вомъ
слꙋ́гъ
слꙋже́нїи
слꙋже́нїѧ
слꙋжи́тель
слꙋчи́читсѧ
слы̑шана
слѣ́дъ
смертоно́сныѧ
смоле́нскагѡ
смотре́нїѧ
смотрѧ́хꙋ
сн҃а
сни́де
со
соблюда́ющїй
соблюдѝ
собо́ра
собра̀
соверша́шесѧ
совокꙋпѝ
согрѣшитѐ
содѣ́ла
сожже́мъ
сокро́вищахъ
сокрꙋши́лъ
сопє́рникъ
сопредстоѧ́тъ
составле́нїѧ
сотворе́ни
сотворе́нїѧ
сотворѝ
сѡхѡ́ѳъ
сохрани́ти
сохранѧ́ѧ
спасѐ
спасе́нїѧ
спаси́
спа́сскихъ
спле́тшесѧ
спобо́ретъ
сподо́би
споспѣ́шника
сп҃са́етсѧ
сп҃са́й
сп҃се
сп҃се́нїѧ
сп҃сѝ
сп҃си́тельное
сп҃сти́
срⷣца́мъ
ст
ст҃а́го
ст҃а́гѡ
стезю̀
стїхи́ра
стїхи̑ры
стїхо́внѣ
стїхосло́вїи
сті́хъ
столпѣ̀
стѡпы̀
страда́льцы
страсте́й
стра̑сти
стра́шна
стрⷭ҇тоте́рпцы
ст҃ꙋ́ю
ст҃ы̑мъ
ст҃ы́нѧ
ст҃ы́хъ
ст҃ы́ѧ
ст҃ѣ́йшемꙋ
стѧжава́ѧ
стѧжа́вше
сꙋббѡ́тꙋ
сꙋ́ть
сꙋ́щаго
сꙋщество̀
сꙋ́щꙋю
сщ҃е́нное
съ
сы́й
сы́нове
сынѡ́въ
сы́номъ
сѣда́ленъ
сѣ́де
сѣ́мени
сѷно́дꙋ
та́же
та́инство
та́кѡ
такова̑ѧ
та́мѡ
тве́рдь
твоѐ
твоегѡ̀
твое́й
твоемꙋ̀
твое́мъ
твое́ю
твоеѧ̀
тво́й
твои́ми
твои́мъ
твои́хъ
творе́нїе
твори́мъ
творца̀
творѧ́хꙋ
творѧ́щихъ
твою̀
твоѧ̀
твоѧ̑
тебѐ
тебє̀
тебѣ́
тебѣ̀
те́плое
ти
тѝ
ти́хїй
тїмоѳе́ю
тлѣ́нїе
тлѣ́нїю
тогда̀
того̀
тогѡ̀
то́й
томꙋ̀
тре́бникъ
тре́бꙋющымъ
трепе́щꙋтъ
трети́цею
трѝ
тридне́вное
трисл҃нечнымъ
трист҃о́е
трїѡ́ди
тропа́рь
трⷪ҇цы
трꙋды̑
трꙋ́пїѧ
трѵ́фѡна
тщы̀
ты́
ты̀
тѣ́мже
тѣ́мъ
тѣ́хъ
тѧ
тѧ́
тѧ̀
ᲂу҆
ᲂу҆̀бо
ᲂу҆бо́жествомъ
ᲂу҆боѧ́сѧ
ᲂу҆гобзи́сѧ
ᲂу҆го́дїѧ
ᲂу҆держава́тисѧ
ᲂу҆диви́сѧ
ᲂу҆диви́шасѧ
ᲂу҆до́бь
ᲂу҆дѡ́въ
ᲂу҆досто́итисѧ
ᲂу҆жасе́сѧ
ᲂу҆́жасъ
ᲂу҆зрѣ́въ
ᲂу҆краси́вшесѧ
ᲂу҆краси́сѧ
ᲂу҆краше́нїе
ᲂу҆кроти́лъ
ᲂу҆крѣпи́тъ
ᲂу҆миле́нїю
ᲂу҆мно́жꙋ
ᲂу҆́мною
ᲂу҆моле́нїе
ᲂу҆́мре
ᲂу҆мре́ти
ᲂу҆па́слъ
ᲂу҆пова́нїи
ᲂу҆пова́ющаго
ᲂу҆подо́бихомсѧ
ᲂу҆рва́нъ
ᲂу҆ро́къ
ᲂу҆слы́ша
ᲂу҆снꙋ́въ
ᲂу҆ста̀
ᲂу҆сте́нъ
ᲂу҆стнѣ̀
ᲂу҆стреми́шасѧ
ᲂу҆стро́илъ
ᲂу҆сты́
ᲂу҆тверди́лъ
ᲂу҆твержде́нїе
ᲂу҆́трени
ᲂу҆́треннїѧ
ᲂу҆́трѡ
ᲂу҆тѣше́нїе
ᲂу҆ченикѝ
ᲂу҆че́нїе
ᲂу҆чи́мый
ᲂу҆чинє́нныѧ
ᲂу҆чи́телю
ᲂу҆ще́дри
фараѡ́ново
фараѡ́нꙋ
фарїсе́є
харра́нь
хвале́нїѧ
хода́таѧ
хо́дитъ
ходи́хъ
ходѧ́щїи
хотѣ́нїемъ
хотѧ́ще
хощꙋ̀
хра́ма
хра́мъ
хра́мѣ
хрⷭ҇та̀
хрⷭ҇тѐ
хрⷭ҇тїа́нѡмъ
хрⷭ҇тїа́нъ
хрⷭ҇то́ва
хрⷭ҇то́вы
хрⷭ҇то́вѣ
хрⷭ҇томꙋ́ченичествомъ
хрⷭ҇то́мъ
хрⷭ҇то́съ
хрⷭ҇тꙋ̀
хрⷭ҇тѣ̀
хꙋдо́жествъ
царе́выхъ
царе́й
царѧ̀
це́ркве
цр҃кве
цр҃кви
цр҃ковь
црⷭ҇твїи
цр҃ѧ̀
цѣлова́нїе
ча́дъ
ча́съ
ча́ша
человѣколю́бче
человѣ́кѡмъ
человѣ̑къ
человѣ́цѣхъ
человѣ́ческихъ
че́сти
че́стнѡ
честны̑ѧ
че́сть
четве́ртый
чинонача̑лїѧ
чи́нꙋ
чи́слити
чи́стъ
чи̑сты
чи́стыѧ
чл҃вѣколюби́вомꙋ
чл҃вѣколю́бца
чл҃вѣ́къ
чл҃вѣ́ческаго
чре́вѣ
чⷭ҇тна̀
чⷭ҇тое
чте́нїе
что́
чтꙋ́ще
чтꙋ́щихъ
чꙋдесѐ
чꙋ̑днаѧ
чꙋ́домъ
чꙋдотво́рцꙋ
шве́нїемъ
ши́покъ
ю҆̀
ю҆́же
ю҆́ности
ꙗ҆ви́сѧ
ꙗ҆вле́ннаѧ
ꙗ҆́вльшꙋюсѧ
ꙗ҆̀же
ꙗ҆зы́цы
ꙗ҆́кѡ
ꙗ҆́коже
ѱало́мъ
ѳеофа́ново
ѳ҃і
ѳѷмїа́мъ
