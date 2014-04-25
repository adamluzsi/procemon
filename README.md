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

# Examples

The "how_to_inject_with_extra_process_a_method"
tells you how to NOT monkey patch methods in modules.
You want use a module? sure awsome !
You need to add plus functionality but dont want to follow the module updates
(in case of conflight with the monkey patch)
Than this is your tool. Tell the method to inject what method and it will , but remember
params are always have to obey to the original method!

The "fun_with_procs_and_methods"
tells you how to play with proc and method objects source code,
combine them, manipulate them, and convert back into live code
with the right bindings

the "simple async processing" will let you use os threads (1.9.n+)
for multiprocessing so you can give multiple task to do and
until you ask for the value, the process will be in the background
You can also use OS threads instead of VM Threads for real Parallelism

the "require_files" shows you how can you get files from directory
in a recursive way and stuffs like that so you can be lay
