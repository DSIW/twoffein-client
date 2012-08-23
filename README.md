# Twoffein-Client
Client-Version: 0.1.0 | API-Version: 0.2

This client for [Twoffein](http://twoffein.com/)'s [API](http://twoffein.com/api-faq/).

## Installation

Add this line to your application's Gemfile:

    gem 'twoffein-client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install twoffein-client

## Usage

```
NAME
    twoffein-client - Client for API 0.2 twoffein.de

SYNOPSIS
    twoffein-client [global options] command [command options] [arguments...]

VERSION
    0.1.0

GLOBAL OPTIONS
    --help    - Show this message
    --version - Show version

COMMANDS
    cookie  - Give cookie to RECEIVER
    drinks  - List all drinks
    help    - Shows a list of commands or help for one command
    profile - List the profile, which you have chosen by PROFILE
    tweet   - Tweet your drinking DRINK

```

### Credentials

You need your credentials (screen_name, api_key) to get access to the Twoffein-API. Please set these as
shell environment variables TWOFFEIN_SCREEN_NAME and TWOFFEIN_API_KEY. Thank's!

    TWOFFEIN_SCREEN_NAME=NAME TWOFFEIN_API_KEY=KEY twoffein-client drinks

## Examples


### Drinks

**Input:**

    twoffein-client drinks

**Output:**
```
Drink                  (key)
--------------------------------------------
Kaffee                 (kaffee)
Milchkaffee            (milchkaffee)
Eiskaffee              (eiskaffee)
Energy Drink           (energiedrink)
Cola                   (cola)
Cola Light             (colalight)
Cola Zero              (colazero)
Cola-Mix               (colamix)
Cola-Mix Light         (colamixlight)
Cola-Mix Zero          (colamixzero)
Bubble Tea             (bubbletea)
Cherry Cola            (cherrycola)
Vanilla Cola           (vanillacola)
Caffé Latte            (cafelatte)
Caffé au Lait          (cafeaulait)
Latte Macchiato        (lattemacchiato)
Espresso Macciato      (espressomacciato)
Espresso con Panne     (espressoconpanne)
Flat White             (flatwhite)
Caffé Breve            (caffebreve)
Caffé Mocha            (caffemocha)
Americano              (americano)
Melange                (melange)
Red Eye                (redeye)
Tee                    (tee)
Eistee                 (eistee)
Kakao                  (kakao)
Mate                   (mate)
Espresso               (espresso)
Cappuccino             (cappuccino)
Vannillochino          (vannillochino)
Instantkaffee          (instantkaffee)
Mokka                  (mokka)
Chai-Latte             (chailatte)
Grünen Tee             (guenertee)
Schwarztee             (schwarztee)
1337MATE               (leetmate)
Club-Mate              (clubmate)
Club-Mate Cola         (clubmatecola)
ICE-Tea KRAFTSTOFF     (kraftstoff)
Premium-Cola           (premiumcola)
Dr Pepper              (drpepper)
Vita Cola              (vitacola)
Vita Cola Mix          (vitacolamix)
Vita Cola Pur          (vitacolapur)
Schokocino             (schokocino)
afri cola              (africola)
afri sugarfree         (afrisugarfree)
afri power             (afripower)
fritz-kola             (fritzkola)
fritz-kola stevia      (fritzkolastevia)
fritz-kola zuckerfrei  (fritzkolazuckerfrei)
mischmasch             (mischmasch)
Haji Cola              (hajicola)
KILLERFISH Hot Energy  (killerfishhotenergy)
Café Frappé            (cafefrappe)
Energy Shot            (energyshot)
Wasser                 (wasser)
Mineralwasser          (mineralwasser)
Apfelsaft              (apfelsaft)
Orangensaft            (orangensaft)
Milch                  (milch)
Sojamilch              (sojamilch)
Orangenlimonade        (orangenlimonade)
Zitronenlimonade       (zitronenlimonade)
Kräuterlimonade        (kraeuterlimonade)
Apfelsaftschorle       (apfelsaftschorle)
Ginger Ale             (gingerale)
Tonic Water            (tonicwater)
Bitter Lemon           (bitterlemon)
Bananensaft            (bananensaft)
Traubensaft            (traubensaft)
Milchshake             (milchshake)
Joghurtdrink           (joghurtdrink)
Smoothie               (smoothie)
Espresso Doppio        (espressodoppio)
Fassbrause             (fassbrause)
Ayran                  (ayran)
Flora Power            (florapower)
VOLT Cola              (voltcola)
COFAIN 699             (cofain669)
Erdbeersaft            (erdbeersaft)
KiBa                   (kiba)
Müllermilch            (muellermilch)
Malzbier               (malzbier)
Rhabarberschorle       (rhabarberschorle)
```

### Drinks (filtered)

**Input:**

    twoffein-client drinks --grep club

**Output:**
```
Drink           (key)
------------------------------
Club-Mate       (clubmate)
Club-Mate Cola  (clubmatecola)
```

### Profile

**Input:**

    twoffein-client profile

**Output:**
```
Quest:                     Blitzlicht
Drink:                     Club-Mate
Rank:                      74
Rank Title:                Kaffeekännchen
Drunken:                   16
Bluttwoffeinkonzentration: 1%
First Login:               2012-07-08 13:36
Screen Name:               DSIW
```

### Cookie

**Input:**

    twoffein-client cookie DSIW

**Output:**
```
Lol.
```

_Notice: You can't send yourself a cookie._

### Tweet

**Input:**

    twoffein-client tweet clubmate

**Output:**
```
Ich trinke gerade Club-Mate.
Info: Youre Tweet has been tweeted. Thanks.
Drinks today: 2
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
