# Ruby Gem Dependency Error on BOLD

##### Client: Phoenix Photo
##### Created: 19.08.15
##### Author: Davy Jones (TS)

--------

# 1. The Symptom

Client rang Tech Support saying that their BOLD was showing just a Grey screen.
This immidiately smelled of an error with the Web-Order-Manager. See Picture below:
![Grey Screen on BOLD](images/RubyGemDependencyError-1.png)

When SSH'd into the box it was seen, using HTOP, that both CPU cores were maxed out!
On closer inspection using `ps -eo ppid,pid,pcpu,args` the following process hierarcy was seen:

>   |--- lightdm
>   |
>   |--- ambit/bin/bol-session
>   |
>   |--- web-order-controller
>   | |
>   |-+- manage-process
>   | |
>   | |- process-feed
>   |--- process-gui

The web-order-controller process was what was causing the cpu overflow. By killing this process via `kill <pid of web-order-controller>` CPU usage returned to normal but obviously this disabled the service.

On attempting to manually reload the service numerous **Ruby 'require'** errors cropped up. Inspecting the `/home/share/logs/ambit-push-daemon.1001.log` the following could be seen:

> Logfile created on 2015-07-31 06:53:58 +0100 by logger.rb/36483
> I, [2015-07-31T06:53:58.770245 #1431] INFO -- : Starting ambit-push-daemon (PID=1431)
> I, [2015-07-31T07:01:49.764769 #1431] INFO -- : Quitting ambit-push-daemon (PID=1431)
> I, [2015-07-31T07:01:50.055459 #4608] INFO -- : Starting ambit-push-daemon (PID=4608)
> I, [2015-07-31T07:08:49.713432 #1437] INFO -- : Starting ambit-push-daemon (PID=1437)
> F, [2015-07-31T07:08:50.322337 #1437] FATAL -- : NoMethodError: undefined method each' for false:FalseClass
> /usr/local/ambit/lib/ruby/ambit/net-config.rb:35:in <module:Remote>'
> /usr/local/ambit/lib/ruby/ambit/net-config.rb:10:in <top (required)>'
> /usr/local/rvm/rubies/ruby-2.0.0-p247/lib/ruby/site_ruby/2.0.0/rubygems/core_ext/kernel_require.rb:45:in require'
> /usr/local/rvm/rubies/ruby-2.0.0-p247/lib/ruby/site_ruby/2.0.0/rubygems/core_ext/kernel_require.rb:45:in require'
> /usr/local/ambit/lib/ruby/ambit/shared-config-data.rb:259:in load'
> /usr/local/ambit/lib/ruby/ambit/shared-config-data.rb:101:in initialize'
> /usr/local/ambit/lib/ruby/ambit/shared-config-data.rb:97:in new'
> /usr/local/ambit/lib/ruby/ambit/shared-config-data.rb:97:in get'
> /usr/local/ambit/lib/ruby/ambit/shared-config-data.rb:9:in get'
> /usr/local/ambit/lib/ruby/ambit/shared-config.rb:309:in load_source'
> /usr/local/ambit/lib/ruby/ambit/shared-config.rb:496:in new_menu'
> /usr/local/ambit/lib/ruby/ambit/shared-config.rb:321:in block in new_group'
> /usr/local/rvm/rubies/ruby-2.0.0-p247/lib/ruby/gems/2.0.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node_set.rb:187:in block in each'
> /usr/local/rvm/rubies/ruby-2.0.0-p247/lib/ruby/gems/2.0.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node_set.rb:186:in upto'
> /usr/local/rvm/rubies/ruby-2.0.0-p247/lib/ruby/gems/2.0.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node_set.rb:186:in each'
> /usr/local/ambit/lib/ruby/ambit/shared-config.rb:316:in new_group'
> /usr/local/ambit/lib/ruby/ambit/shared-config.rb:296:in block in parse!'
> /usr/local/rvm/rubies/ruby-2.0.0-p247/lib/ruby/gems/2.0.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node_set.rb:187:in block in each'
> /usr/local/rvm/rubies/ruby-2.0.0-p247/lib/ruby/gems/2.0.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node_set.rb:186:in upto'
> /usr/local/rvm/rubies/ruby-2.0.0-p247/lib/ruby/gems/2.0.0/gems/nokogiri-1.6.6.2/lib/nokogiri/xml/node_set.rb:186:in each'
> /usr/local/ambit/lib/ruby/ambit/shared-config.rb:293:in parse!'
> /usr/local/ambit/lib/ruby/ambit/shared-config.rb:281:in initialize'
> /usr/local/ambit/lib/ruby/ambit/shared-config.rb:698:in new'
> /usr/local/ambit/lib/ruby/ambit/shared-config.rb:698:in schema'
> /usr/local/ambit/lib/ruby/ambit/shared-config.rb:741:in []'
> /usr/local/ambit/bin/ambit-pushd:45:in mainloop'
> /usr/local/ambit/lib/ruby/ambit/daemon.rb:138:in block in daemon_main'
> /usr/local/ambit/lib/ruby/ambit/daemon.rb:138:in loop'
> /usr/local/ambit/lib/ruby/ambit/daemon.rb:138:in daemon_main'
> /usr/local/ambit/lib/ruby/ambit/daemon.rb:23:in start'
> /usr/local/ambit/bin/ambit-pushd:86:in <main>'

The lightweight downloader service was running as expected.

# 2. The Why

The root cause was tracked down to a specific version of a Ruby Gem (Nokogiri 1.6.62). This was updated from ver. 1.6.0 by the `Backup` Ruby Gem that was being used to do some remote backup work.

Ambit requires only version 1.6.0 is has been seen.

# 3. The Fix

Uninstall the Nokogiri 1.6.6.2 gem from the machine using:
```shell
  sudo gem uninstall nokogiri --version 1.6.6.2
  sudo shutdown -r now # sudo reboot now doesn't fully reboot machine! 
```
