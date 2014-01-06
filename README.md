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

the "require_files" shows you how can you get files from directory
in a recursive way and stuffs like that so you can be lay

## LICENSE

(The MIT License)

Copyright (c) 2009-2013 Adam Luzsi <adamluzsi@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
