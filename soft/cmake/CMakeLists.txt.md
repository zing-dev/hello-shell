# CMakeLists.txt编写入门


## 自定义变量
   
```
主要有隐式定义和显式定义两种。 
隐式定义的一个例子是PROJECT指令，
它会隐式的定义< projectname >_BINARY_DIR
和< projectname >_SOURCE_DIR两个变量；
显式定义使用SET指令构建自定义变量，比如:SET(HELLO_SRCmain.c)
就可以通过${HELLO_SRC}来引用这个自定义变量了。

```

## 变量引用方式
```
使用${}进行变量的引用；在IF等语句中,是直接使用变量名而不通过${}取值。
```


## 常用变量

- `CMAKE_BINARY_DIR` 
- `PROJECT_BINARY_DIR` 
- `< projectname >_BINARY_DIR` 

```
 这三个变量指代的内容是一致的，
 如果是in-source编译，指得就是工程顶层目录；
 如果是out-of-source编译，指的是工程编译发生的目录。
 PROJECT_BINARY_DIR跟其它指令稍有区别，目前可以认为它们是一致的。
```

- `CMAKE_SOURCE_DIR` 
- `PROJECT_SOURCE_DIR` 
- `< projectname >_SOURCE_DIR` 
```
这三个变量指代的内容是一致的，
不论采用何种编译方式，都是工程顶层目录。
也就是在in-source编译时,他跟CMAKE_BINARY_DIR等变量一致。
PROJECT_SOURCE_DIR跟其它指令稍有区别,目前可以认为它们是一致的。 
out-of-source build与in-source build相对，
指是否在CMakeLists.txt所在目录进行编译。）
```

- `CMAKE_CURRENT_SOURCE_DIR` 
```
当前处理的CMakeLists.txt所在的路径，比如上面我们提到的src子目录。
```

- `CMAKE_CURRRENT_BINARY_DIR` 
```
如果是in-source编译，它跟CMAKE_CURRENT_SOURCE_DIR一致；
如果是out-of-source编译，指的是target编译目录。
使用ADD_SUBDIRECTORY(src bin)可以更改这个变量的值。
使用SET(EXECUTABLE_OUTPUT_PATH <新路径>)并不会对这个变量造成影响,
它仅仅修改了最终目标文件存放的路径。
```

- `CMAKE_CURRENT_LIST_FILE` 
```
输出调用这个变量的CMakeLists.txt的完整路径
```

- `CMAKE_CURRENT_LIST_LINE` 
```
输出这个变量所在的行
```

- `CMAKE_MODULE_PATH` 
```
这个变量用来定义自己的cmake模块所在的路径。
如果工程比较复杂，有可能会自己编写一些cmake模块，
这些cmake模块是随工程发布的，
为了让cmake在处理CMakeLists.txt时找到这些模块，
你需要通过SET指令将cmake模块路径设置一下。
比如SET(CMAKE_MODULE_PATH,${PROJECT_SOURCE_DIR}/cmake) 
这时候就可以通过INCLUDE指令来调用自己的模块了。
```

- `EXECUTABLE_OUTPUT_PATH` 
```
新定义最终结果的存放目录
```

- `LIBRARY_OUTPUT_PATH` 
```
新定义最终结果的存放目录
```

- `PROJECT_NAME` 
```
返回通过PROJECT指令定义的项目名称。
```

## cmake调用环境变量的方式
   
- 使用$ENV{NAME}指令就可以调用系统的环境变量了。
- 比如MESSAGE(STATUS "HOME dir: $ENV{HOME}")
- 设置环境变量的方式是SET(ENV{变量名} 值)。

- `CMAKE_INCLUDE_CURRENT_DIR` 
```
自动添加CMAKE_CURRENT_BINARY_DIR和
CMAKE_CURRENT_SOURCE_DIR到当前处理的CMakeLists.txt，
相当于在每个CMakeLists.txt加入：
INCLUDE_DIRECTORIES(${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR})
```

- `CMAKE_INCLUDE_DIRECTORIES_PROJECT_BEFORE` 
```
将工程提供的头文件目录始终置于系统头文件目录的前面,
当定义的头文件确实跟系统发生冲突时可以提供一些帮助。
```

- `CMAKE_INCLUDE_PATH和CMAKE_LIBRARY_PATH`

## 系统信息

- `CMAKE_MAJOR_VERSION`，CMAKE主版本号，比如2.4.6中的2
- `CMAKE_MINOR_VERSION`，CMAKE次版本号，比如2.4.6中的4
- `CMAKE_PATCH_VERSION`，CMAKE补丁等级，比如2.4.6中的6
- `CMAKE_SYSTEM`，系统名称，比如Linux-2.6.22
- `CMAKE_SYSTEM_NAME`，不包含版本的系统名，比如Linux
- `CMAKE_SYSTEM_VERSION`，系统版本，比如2.6.22
- `CMAKE_SYSTEM_PROCESSOR`，处理器名称，比如i686
- `UNIX`，在所有的类Unix平台为TRUE，包括OSX和cygwin
- `WIN32`，在所有的Win32平台为TRUE，包括cygwin


## 主要的开关选项

- `CMAKE_ALLOW_LOOSE_LOOP_CONSTRUCTS` 
```
用来控制IF ELSE语句的书写方式。
```

- `BUILD_SHARED_LIBS` 
```
这个开关用来控制默认的库编译方式。
如果不进行设置，
使用ADD_LIBRARY并没有指定库类型的情况下，默认编译生成的库都是静态库；
如果SET(BUILD_SHARED_LIBSON)后,默认生成的为动态库。
```

- `CMAKE_C_FLAGS` 
```
设置C编译选项，也可以通过指令ADD_DEFINITIONS()添加。
```

- `MAKE_CXX_FLAGS` 
```
设置C++编译选项，也可以通过指令ADD_DEFINITIONS()添加。
```


## `CMake`常用指令
- 这里引入更多的cmake指令,为了编写的方便,将按照cmakeman page 的顺序介绍各种指令，不再推荐使用的指令将不再介绍。

### 基本指令

#### `PROJECT(HELLO)` 
- 指定项目名称，生成的VC项目的名称，使用${HELLO_SOURCE_DIR}表示项目根目录。

#### `INCLUDE_DIRECTORIES` 
- 指定头文件的搜索路径，相当于指定gcc的-I参数 
- `INCLUDE_DIRECTORIES(${HELLO_SOURCE_DIR}/Hello)` #增加Hello为include目录

#### `TARGET_LINK_LIBRARIES` 
- 添加链接库，相同于指定-l参数 
- `TARGET_LINK_LIBRARIES(demoHello)` #将可执行文件与Hello连接成最终文件demo

#### `LINK_DIRECTORIES` 
- 动态链接库或静态链接库的搜索路径，相当于`gcc`的`-L`参数 
- `LINK_DIRECTORIES(${HELLO_BINARY_DIR}/Hello)` #增加Hello为link目录

#### `ADD_DEFINITIONS` 
- 向`C/C++`编译器添加`-D`定义，比如： 
- `ADD_DEFINITIONS(-DENABLE_DEBUG-DABC)` 
- 参数之间用空格分割。如果代码中定义了:

    ```c
    #ifdef ENABLE_DEBUG
    #endif
    ```

- 这个代码块就会生效。如果要添加其他的编译器开关,可以通过`CMAKE_C_FLAGS`变量和`CMAKE_CXX_FLAGS`变量设置。

#### `ADD_DEPENDENCIES*` 
- 定义`target`依赖的其它`target`，确保在编译本`target`之前，其它的`target`已经被构建。`ADD_DEPENDENCIES`(`target-name depend-target1 depend-target2 ...`)

- `ADD_EXECUTABLE` 
- `ADD_EXECUTABLE(helloDemo demo.cxx demo_b.cxx)` 
- 指定编译，好像也可以添加.o文件，将cxx编译成可执行文件

#### `ADD_LIBRARY` 
- `ADD_LIBRARY`(`Hellohello.cxx`) #将`hello.cxx`编译成静态库如`libHello.a`

#### `ADD_SUBDIRECTORY` 
- `ADD_SUBDIRECTORY`(`Hello`) #包含子目录

#### `ADD_TEST` 
- `ENABLE_TESTING` 
- `ENABLE_TESTING`指令用来控制`Makefile`是否构建`test`目标，涉及工程所有目录。语法很简单，没有任何参数，`ENABLE_TESTING()`一般放在工程的主`CMakeLists.txt`中。 
- `ADD_TEST`指令的语法是:`ADD_TEST`(`testnameExename arg1 arg2 …`) 
- `testname`是自定义的`test`名称，`Exename`可以是构建的目标文件也可以是外部脚本等等，后面连接传递给可执行文件的参数。

- 如果没有在同一个`CMakeLists.txt`中打开`ENABLE_TESTING()`指令，任何`ADD_TEST`都是无效的。比如前面的`Helloworld`例子,可以在工程主`CMakeLists.txt`中添加
```
ADD_TEST(mytest ${PROJECT_BINARY_DIR}/bin/main)
ENABLE_TESTING
```
- 生成Makefile后，就可以运行make test来执行测试了。

#### `UX_SOURCE_DIRECTORY` 
- 基本语法是:`AUX_SOURCE_DIRECTORY(dir VARIABLE)`，作用是发现一个目录下所有的源代码文件并将列表存储在一个变量中，这个指令临时被用来自动构建源文件列表，因为目前`cmake`还不能自动发现新添加的源文件。比如：
```
AUX_SOURCE_DIRECTORY(. SRC_LIST)
ADD_EXECUTABLE(main ${SRC_LIST})
```
- 可以通过后面提到的FOR EACH指令来处理这个LIST。

#### `CMAKE_MINIMUM_REQUIRED` 
- 语法为`CMAKE_MINIMUM_REQUIRED`(`VERSION versionNumber [FATAL_ERROR]`)， 
- 比如:`CMAKE_MINIMUM_REQUIRED(VERSION 2.5 FATAL_ERROR)` 
- 如果`cmake`版本小与2.5，则出现严重错误，整个过程中止。


#### `EXEC_PROGRAM`
- 在`CMakeLists.txt`处理过程中执行命令，并不会在生成的`Makefile`中执行。具体语法为:
```
EXEC_PROGRAM(
    Executable 
        [directory in which to run] 
        [ARGS <arguments to executable>] 
        [OUTPUT_VARIABLE <var>] 
        [RETURN_VALUE <var>]
)
```
 
- 用于在指定的目录运行某个程序，通过`ARGS`添加参数，
- 如果要获取输出和返回值，可通过`OUTPUT_VARIABLE`和`RETURN_VALUE`分别定义两个变量。 
- 这个指令可以帮助在`CMakeLists.txt`处理过程中支持任何命令，
- 比如根据系统情况去修改代码文件等等。
- 举个简单的例子，我们要在`src`目录执行`ls`命令，并把结果和返回值存下来，
- 可以直接在`src`/`CMakeLists.txt`中添加：
```
EXEC_PROGRAM(ls ARGS "*.c" OUTPUT_VARIABLE LS_OUTPUT RETURN_VALUE LS_RVALUE)
IF(not LS_RVALUE)
    MESSAGE(STATUS "ls result: " ${LS_OUTPUT})
ENDIF(not LS_RVALUE)
```

- 在`cmake`生成`Makefile`过程中，就会执行`ls`命令，
- 如果返回0，则说明成功执行，那么就输出ls *.c的结果。
- 关于IF语句，后面的控制指令会提到。

#### `FILE指令` 
- 文件操作指令，基本语法为:
- `FILE(WRITEfilename "message to write"... )`
- `FILE(APPENDfilename "message to write"... )`
- `FILE(READfilename variable)`
- `FILE(GLOBvariable [RELATIVE path] [globbing expression_r_rs]...)`
- `FILE(GLOB_RECURSEvariable [RELATIVE path] [globbing expression_r_rs]...)`
- `FILE(REMOVE[directory]...)`
- `FILE(REMOVE_RECURSE[directory]...)`
- `FILE(MAKE_DIRECTORY[directory]...)`
- `FILE(RELATIVE_PATHvariable directory file)`
- `FILE(TO_CMAKE_PATHpath result)`
- `FILE(TO_NATIVE_PATHpath result)`

#### `INCLUDE指令` 
- 用来载入CMakeLists.txt文件，也用于载入预定义的cmake模块。
- `INCLUDE(file1[OPTIONAL])`
- `INCLUDE(module[OPTIONAL])`
- `OPTIONAL`参数的作用是文件不存在也不会产生错误，可以指定载入一个文件，
- 如果定义的是一个模块，那么将在`CMAKE_MODULE_PATH`中搜索这个模块并载入，
- 载入的内容将在处理到`INCLUDE`语句是直接执行。

#### `INSTALL指令`

- `FIND`_指令 
- `FIND`_系列指令主要包含一下指令:
- `FIND_FILE(<VAR>name1 path1 path2 …)`    `VAR`变量代表找到的文件全路径,包含文件名
- `FIND_LIBRARY(<VAR>name1 path1 path2 …)`    `VAR`变量表示找到的库全路径,包含库文件名
- `FIND_PATH(<VAR>name1 path1 path2 …)`   `VAR`变量代表包含这个文件的路径
- `FIND_PROGRAM(<VAR>name1 path1 path2 …)`   `VAR`变量代表包含这个程序的全路径
- `FIND_PACKAGE(<name>[major.minor]  [QUIET] [NO_MODULE] [[REQUIRED|COMPONENTS][componets...]])`   
- 用来调用预定义在`CMAKE_MODULE_PATH下`的`Find<name>.cmake`模块，也可以自己定义`Find<name>`模块，
- 通过`SET(CMAKE_MODULE_PATH dir)`将其放入工程的某个目录中供工程使用，后面会详细介绍`FIND_PACKAGE`的使用方法和`Find`模块的编写。

##### FIND_LIBRARY示例:
```
FIND_LIBRARY(libXX11 /usr/lib)
IF(NOT libX)
    MESSAGE(FATAL_ERROR "libX not found")
ENDIF(NOT libX)
```

### 控制指令
    
- `IF`指令，基本语法为:
```
IF(expression_r_r)
    #THEN section.
    COMMAND1(ARGS…)
    COMMAND2(ARGS…)
    …
ELSE(expression_r_r)
    #ELSE section.
    COMMAND1(ARGS…)
    COMMAND2(ARGS…)
    …
ENDIF(expression_r_r)
```

- 另外一个指令是`ELSEIF`，总体把握一个原则，凡是出现IF的地方一定要有对应的`ENDIF`，出现`ELSEIF`的地方，`ENDIF`是可选的。
- 表达式的使用方法如下:
```
IF(var)  如果变量不是：空, 0, N, NO, OFF, FALSE, NOTFOUND 或 <var>_NOTFOUND时，表达式为真。
IF(NOT var)， 与上述条件相反。
IF(var1AND var2)， 当两个变量都为真是为真。
IF(var1OR var2)， 当两个变量其中一个为真时为真。
IF(COMMANDcmd)， 当给定的cmd确实是命令并可以调用是为真。
IF(EXISTS dir) or IF(EXISTS file)， 当目录名或者文件名存在时为真。
IF(file1IS_NEWER_THAN file2)， 当file1比file2新，或者file1/file2其中有一个不存在时为真文件名请使用完整路径。
IF(IS_DIRECTORY dirname),  当dirname是目录时为真。
IF(variableMATCHES regex)
```


[url](http://blog.csdn.net/z_h_s/article/details/50699905)