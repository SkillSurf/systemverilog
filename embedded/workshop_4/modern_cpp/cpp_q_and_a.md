# Answers to C++ Slido Questions

### Sir, as You have got so many experiences, please share how you have come so far. It would be really motivational
[Answer as facebook post](https://www.facebook.com/groups/891459401413893/permalink/907122263180940)

### We can return vector from c++ functions but can't return an array. Is it right? Why is that?

An std::vector is an object, just like variables made from datatypes, objects made from classes can be returned. Array (c-style array) is basically a fancy pointer, and it behaves weirdly due to backward compatibility with C. You cant also pass an array into a function. It becomes a simple pointer and size information is lost. So, stop using arrays and start using std::array. It is similar, but an object.

### How we can store a value in a particular memory address using c++?

```c++
// more readable. Not a waste of memory, compiler may optimize into one line
int * ptr = (int*)(0x7889);
*ptr = 42;
// one line
*((int*)(0x7889)) = 42;
```
This should save the int value to that memory location. We are casting the address as (int* = int pointer). This says to pick 4 bytes starting from that address. Then we dereference the pointer with first * to access the value in that address. Then we assign 42 to it. 

Generally, this is not a good idea. The system keeps track of the memory which is allocated and unallocated. The right way is using new (or smart pointers) to “ask nicely” for memory. Else, you might overwrite an existing value (program will be corrupt) or the system may assign this address to a following “new” request, causing this value to be lost. However, in embedded systems, sometimes there is a range of memory that is not part of a stack or heap. See datasheet of the chip. You can freely assign like this into that range. Also, u can do this when writing to registers (as those are not freely used by the system)

### Is there anything that can not be written without using pointers?

Every variable, function and object is stored somewhere in the memory. So they can be accessed by a pointer (address of the first byte). If you use inline functions, the compiler might (not always) optimize it into a functionless set of code. #define is preprocessor directive. This means it simply finds and replaces all occurrences of the name before sending the code to the compiler. You cant get a pointer to that.

### what is the actual use of pointers?

Well, the power of C++ is in the ability to finely manipulate memory. Pointers give you the memory address where data is stored. You can do whatever u want with it. For example, u can save read the raw bits in memory in different ways, by reinterpret cast.

### Can we do avr programming on linux?

Yes. I havent done it. But googling gave these [tutorials](https://swharden.com/blog/2013-01-06-avr-programming-in-linux/)

### Can't I upload my code into Atmega microcontroller by connecting it to arduino board and upload the code into arduino by usb? Sir, after bootloading a ATMega 328p can't we use it to programe with micro chip studio?

You can program an arduino / bootladed atmega chip using microchip studio. Select ardunio project.

### what does it mean by a "namespace"? and for what does "std" stands for?

Namespaces are a great idea in C++ and used in python too (widely). The idea is to prevent naming collisions and provide context. When u write huge programs with millions of lines of code, if u define everything as we normally do, after some time, we will start getting errors that the name we are trying to define is already in use. So, we can break parts of the code into namespaces. A namespace can be discontinuous, even defined over multiple files. Std, the standard library is such a namespace. It spans the vector, list, iostream and many files. 

Vector.h file might define the templated vector class inside an std namespace. This is done to prevent it colliding with any variable you might have named “vector”. This is a real problem for legacy code. Code is written in 1980s can be mixed with modern code and compiled with same modern compiler without much changes due to this. If someone has defined a variable “vector” in 1990s, and C++11 (2011) introduced the feature vector without putting it into std namespace, that code won’t compile.

Also, they provide context. Matlab puts all functions into same namespace and its a pain. Python libraries, split them into appropriate groups (torch.nn.Conv2d), so it makes more sense.

### For a function with no arguments, we can leave the brackets blank as: int my_func(); and also define as: int my_func(void); are these two functions identical?

In C++, both identical. C, nope

Disclaimer: I'm not a C++ expert. I might have some misconceptions. Feel free to correct me / argue.
