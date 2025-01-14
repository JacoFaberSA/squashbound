# Squashbound

AWS Game Builder Challenge.

Squashbound is a game where you play a very simplified game of squash using a hero of your choice. This is a couch co-op game where you can play with a friend on the same device each taking turns to play.

The game starts with each player choosing a hero. Each hero has a power, speed and stamina stat.

### Stats

- Power: This decreases the amount of time the opponent has to react in order to prevent the attacking player from scoring a point.
- Speed: This increases the speed of the reaction meter.
- Stamina: This is required to attack, defend and use skills.

### Skills

Each hero card has a special skill that can be activated or deactivated during the game to give the player an advantage.

### Game play

After choosing the heroes there is a coin flip to determine which player moves first. During at turn a player can activate/deactivate their hero's skill or attack.

The when attacked the opposing player can choose to react or concede if they do not have enough stamina or want to conserve stamina.

If they react they must tap anywhere on the screen within a certain time frame to prevent the attacking player from scoring a point. The success size decreases based on the attacking player's power stat.

If the opposing player fails to react in time or conceded the attacking player scores a point.

If they successfully react the volley continues until one player fails or concedes. Each rally increases the points scored by 1. If the attacking player fails to score a point the volley ends and the other player gets a chance to attack and they gain the accumulated points.

The game ends when one player reaches 11 points.

### Heroes

There are 12 heroes to choose from. Each hero has a unique skill and stats.

#### Barbarian
Skill: Raging Smash
Raging Smash increases Power by 2 if a volley is successful.

#### Bard
Skill: Inspiring Tune
Inspiring Tune grants 1 additional Speed and Power every time a perfect volley is made.

#### Cleric
Skill: Divine Recovery
Divine Recovery restores 25% stamina at the start of every turn.

#### Druid
Skill: Nature's Harmony
Nature's Harmony increases Speed by 2 when attacked.

#### Fighter
Skill: Battle Resolve
After losing a point, the Battle Resolve increases all stats by 1.

#### Monk
Skill: Zen Focus
While using Zen Focus volleys do not consume stamina.

#### Paladin
Skill: Holy Presence
Holy Presence reduces the opponent's Power stat by 50%.

#### Ranger
Skill: Hunter's Precision
Hunter's Precision doubles speed for the first volley.

#### Rogue
Skill: Sudden Strike
Sudden Strike increases Power x2 for every perfect volley.

#### Sorcerer
Skill: Arcane Surge
For every perfect volley Arcane Surge restores 5 stamina and increases Speed by 1.

#### Warlock
Skill: Soul Tether
Soul Tether restores 10 stamina for every successfully volley.

#### Wizard
Skill: Arcane Focus
Perfect volleys reduce the opponents stamina by 10 and increases Speed by 1.

## Running Squashbound

Requires Flutter 3.27.1

```bash
flutter pub get
flutter run -d chrome
```

## Use of AWS Services

- Amplify: Hosting
- S3: Artwork storage
- CloudFront: CDN for artwork

## Use of Amazon Q

- Used to create the reaction meter mechanism using the Ctrl + I insert feature.
- Used to create the coin flip spinner using the Ctrl + I insert feature.
- Used to set up the theme file using the Ctrl + I insert feature and the autosuggest feature.
- Used to build the game logic using the autosuggest feature.