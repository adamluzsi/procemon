procemon
========

Gotta catch em all!
This is a collection of my Ruby Procs in the adventure of becoming the best!


This is including Tons of monkey_patch for new features to classes,
meta-programing tricks, terminal argument controls, daemonise trick,
tmp folder helpers, Application centralized datas, folder structure logic ,
meta data control, dynamic lib read etc


short lazy doc



in Str2duck

convert string object to something what is it looks to be as duck type mean to do
useful for RESTfull aps when data sent as string
duck


in Tmp_dir

init a tmpdir in the OS tmp folder with the application name
(by default this is the root folder name)
tmpdir_init


in Name

what it looks to be
set_app_name_by_root_folder


in Argv

what it looks to be
process_parameters


in Daemon

Checks to see if the current process is the child process and if not
will update the pid file with the child pid.
self.start pid, pidfile, outfile, errfile

Attempts to write the pid of the forked process to the pid file.
self.write pid, pidfile

Try and read the existing pid from the pid file and signal the
process. Returns true for a non blocking status.
self.kill(pidfile)

Send stdout and stderr to log files for the child process
self.redirect outfile, errfile
self.daemonize
self.kill_with_pid
self.terminate
self.kill_by_name(*args)
self.stop
self.init


in Inject_methods

this will inject a code block to a target instance method
by default the before or after sym is not required
default => before

 Test.inject_singleton_method :hello do |*args|
   puts "singleton extra, so{args[0]}"
 end

inject_singleton_method(method,options=:before,&block)

Singleton.methods[self.object_id]= self.method(method)
this will inject a code block to a target singleton method
by default the before or after sym is not required
default => before

 Test.inject_instance_method :hello, :before do |*args|
   puts "singleton on a instance method and "+args[0]
 end

inject_instance_method(method,options=:before,&block)


in Require

load meta-s
meta_load(app_folder= Dir.pwd)

find elements
get_meta_config(app_folder= Dir.pwd)

defaults
find elements
defaults
processing
return data
mount libs
mount_libs(app_folder= Dir.pwd)

load lib files
Offline repo activate
mount_modules(app_folder= Dir.pwd)

Return File_name => File_path
get_files(folder)

Validation
Check that does the folder is absolute or not
Get Files list
Return file_name:folder
require by absolute path directory's files
require_directory(folder)

require sender relative directory's files
require_relative_directory(folder)

generate config from yaml (default is app_root/config folder)
generate_config(target_config_hash= Application.config,app_folder= Dir.pwd)

try load all the ruby files marked with "generate" in they name from app_root/docs
generate_documentation(boolean= false,keyword= "generate",app_folder= Dir.pwd)


in Port

get_port(mint_port,max_port,host="0.0.0.0")
port_open?(port,host="0.0.0.0")


in Eval

NOT working yet, need to rework the exclude method
safe_eval(string [, binding [, filename [,lineno]]] *allowed_class/module_names )  -> obj

Evaluates the Ruby expression(s) in <em>string</em>. If
<em>binding</em> is given, which must be a <code>Binding</code>
object, the evaluation is performed in its context. If the
optional <em>filename</em> and <em>lineno</em> parameters are
present, they will be used when reporting syntax errors.

   def get_binding(str)
     return binding
   end
   str = "hello"
   safe_eval "str + ' Fred'" ,Kernel#=> "hello Fred"
   safe_eval "str + ' Fred'", get_binding("bye") ,Kernel#=> "bye Fred"
safe_eval(*args)


in Process

self.daemonize
self.stop


in String

Find string in othere string
positions(oth_string)

return value
Standard in rails. See official documentation
[http://api.rubyonrails.org/classes/ActiveSupport/CoreExtensions/String/Inflections.html]
camelize(first_letter = :upper)

Standard in rails. See official documentation
[http://api.rubyonrails.org/classes/ActiveSupport/CoreExtensions/String/Inflections.html]
dasherize

Standard in rails. See official documentation
[http://api.rubyonrails.org/classes/ActiveSupport/CoreExtensions/String/Inflections.html]
demodulize

Standard in rails. See official documentation
[http://api.rubyonrails.org/classes/ActiveSupport/CoreExtensions/String/Inflections.html]
underscore

Check that instance of String is start with an upper case or not
capitalized?


in Yml

self.save_file(file_path,config_hash)

self.load_file(file_path)


in Object

The hidden singleton lurks behind everyone
metaclass; class << self; self; end; end

extend the metaclass with an instance eval
meta_eval &blk; metaclass.instance_eval &blk; end

Adds methods to a metaclass
meta_name, &blk

Defines an instance method within a class
class_name, &blk

constantize object
constantize

find and replace object in object
find_and_replace(input,*params)

it was made only for fun to make same each to array and hash and everything
each_universal(&block)

map an object => experiment
map_object(symbol_key="$type")

is class?
class?

convert class instance instance variables into a hash object
convert_to_hash

this will check that the class is
defined or not in the runtime memory
class_exists?

This will convert a symbol or string and format to be a valid
constant name and create from it a class with instance attribute accessors
Best use is when you get raw data in string from external source
and you want make them class objects

  :hello_world.to_class(:test)
  HelloWorld.to_class(:sup)
  hw_var = HelloWorld.new
  hw_var.sup = "Fine thanks!"
  hw_var.test = 5

  puts hw_var.test

> produce 5 :Integer

  you can also use this formats
  :HelloWorld , "hello.world",
  "hello/world", "Hello::World",
  "hello:world"...
to_class(*attributes)
or
create_attributes(*attributes)

in File

self.create(route_name ,filemod="w",string_data=String.new)


in Array

remove arguments or array of
parameters from the main array
trim(*args)

return index of the target element
index_of(target_element)

remove n. element from the end
and return a new object
pinch n=1

remove n. element from the end
and return the original object
pinch! n=1

return boolean by other array
all element included or
not in the target array
contain?(oth_array)#anothere array

do safe transpose
safe_transpose


in Class

get singleton methods to target class without super class methods
class_methods

bind a singleton method to a class object
create_class_method(method,&block)

create an instance method
create_instance_method(method,&block)

Iterates over all subclasses (direct and indirect)
each_subclass

Returns an Array of subclasses (direct and indirect)
subclasses

Returns an Array of direct subclasses
direct_subclasses

create singleton attribute
class_attr_accessor(name)

GET
SET
create class instance attribute
instance_attr_accessor(name)


in Integer

because for i in integer/fixnum not working,
here is a little patch
each &block


in Random

string(length= 7,amount=1)

integer(length= 3)

boolean

time from = Time.at(1114924812), to = Time.now

date from = Time.at(1114924812), to = Time.now

datetime from = Time.at(1114924812), to = Time.now


in Hash

remove elements by keys,
array of keys,
hashTags,
strings
trim(*args)

pass single or array of keys, which will be removed, returning the remaining hash
remove!(*keys)

non-destructive version
remove(*keys)

Returns a new hash with +self+ and +other_hash+ merged recursively.

  h1 = {:x => {:y => [4,5,6]}, :z => [7,8,9]}
  h2 = {:x => {:y => [7,8,9]}, :z => "xyz"}
#
  h1.deep_merge(h2#=> { :x => {:y => [7, 8, 9]}, :z => "xyz" }
  h2.deep_merge(h1#=> { :x => {:y => [4, 5, 6]}, :z => [7, 8, 9] }
deep_merge(other_hash)

Same as +deep_merge+, but modifies +self+.
deep_merge!(other_hash)

return bool that does the sub hash all element include the hash who call this or not
deep_include?(sub_hash)


in Kernel

eats puts like formated printf method
just use an integer what will be the distance
between elements and the elements next to it
putsf(integer,*args)