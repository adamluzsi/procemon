procemon
========

Gotta catch em all!
This is a collection of my Ruby Procs in the adventure of becoming the best!


This is including Tons of monkey_patch for new features to classes,
meta-programing tricks, terminal argument controls, daemonise trick,
tmp folder helpers, Application centralized datas, folder structure logic ,
meta data control, dynamic lib read etc


There is really lot of helper method, i mean i even lose my life love if i want to start describe all of them
you can generate rdoc if you want, i more like examples, so from now on,
i will make examples!

The first one tells you how to NOT monkey patch methods in modules.
You want use a module? sure awsome !
You need to add plus functionality but dont want to follow the module updates
(in case of conflight with the monkey patch)
Than this is your tool. Tell the method to inject what method and it will , but remember
params are always have to obey to the original method!