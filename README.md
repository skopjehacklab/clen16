# Член 16

[Повеќе за член16.](http://skopjehacklab.github.com/blackout-mk/more.html)

## Инсталација
```bash
git clone git://github.com/skopjehacklab/clen16.git
```

Во votes/za votes/vozdrzan votes/protiv треба да ги ги ставиш сликите (*.png) и името на сликите да биде името на пратеникот на кирилица. Сликите според првото гласање се на https://planet.softver.org.mk/all_imgs.zip

## Crontab configuration
```bash
*/59 * * * * bash -l -c "cd /home/clen16/ && /usr/bin/ruby /home/clen16/clen16.rb >> /home/json/clen16/clen16.log 2>&1"
```