July 20
------------------

Okay, the story so far...

There is a very simple and elegant language (or just notation) that can
be defined as "Joy in the Continuation-Passing Style".  I've written a
type-inference and -checking system for it, and integrated it in the UI
so that the user can only execute commands that type-check with the
current contents of the stack.  When new commands are defined (by making
new Joy code) they are type-checked to make sure they have no internal
inconsistencies and invalid definitions are rejected.

So, a simple, elegant, Turing-complete notation, that is easy to use and
understand while being sophisticated in structure.  (For example,
high-level abstract discussion of recursion is much simpler in Joy than
"Squiggol".)

Now that I have this solid base, I'm using e.g. "Structure and
Interpretation of Classical Mechanics" by Gerald Jay Sussman and Jack
Wisdom, to implement physical modeling software on an elegant (Clifford
Algebra) computationally rigorous foundation.  (Of course, leveraging
Numpy and Sympy and all the rest.)

Overall, my emphasis now has to shift from implementation of the system
itself to developing applications for the system.  When I say
"applications" here I'm using the word in the older, original sense, I
want to apply the system to specific domains to evolve a powerful core of
capabilities.  There aren't separate "Apps".  This process will also
round out the rough edges in the UI.

There are a few things on the list still to do on the base system:  it
should have logging I think; all work is saved in a git repo but there's
currently no in-system way to view or "pull" from the history, (a
facility I call "backtime" in analogy to the "backspace" key); you should
probably be able to edit more than a single text file; etc.

I'm really encouraged by the possibilities of "Categorical" programming.
Conal Elliott's "Compiling with Categories" shows that I'm not barking up
the wrong tree there.  In effect, the same Joy code can be run in
different categories to get different (valid!) computations.  My
inferencer is basically doing exactly that: it evaluates expressions in a
"category" of stack-effect-comments (like in Forth) and type variables,
and the same Joy code delivers the stack effect of that code, rather than
the normal calculation that the normal interpreter would perform.  As if
that were not awesome enough, one of the categories will deliver Verilog
code for the Joy code!  I haven't implemented that category yet but of
course it's on the list!  And of course this also points the way to Joy
compilers (to C or asm or whatever!)


August 10
-----------------------

So not too long ago, maybe a month, a paper went by on HN about writing
compilers in Prolog.  It was written by the same David Warren for whom
the Warren Abstract Machine was named.  It turns out researchers have been investigating
compiling and code generation using Logical Paradigm code.

When I was implementing the type inference for Joy in Python there
was a point when I realized that I should probably switch to Prolog or
miniKanren if I really wanted to do anything weird, like propagate
constraints or something. That, plus reading the paper, got me to
reimplement Joy in Prolog.

Joy in Prolog turns out to be very elegant.  Now I have a kind of
interpreter in Prolog.  It's also a stack effect inferencer due to the
way Prolog works.  I didn't realize this at first.  I implemented the
interpreter, then I implemented the type inferencer and only then
realized that it was essentially identical to the interpreter.  In
hindsight, it's a little obvious.

Compiling is coming along.  "Basic blocks" of simple functions are easy,
I think compiling branches will be easy, dunno about loops and recursion.

"Logic Programming and Compiler Writing"

http://sovietov.com/tmp/warren1980.pdf

https://news.ycombinator.com/item?id=17674859


August 11
--------------------

I've embedded Joy into Prolog.  That's a Pure, Functional interpreter
inside the Logical Paradigm powerhouse.  I /could/ present it as "the
thing" and wrap prolog predicates in Joy functions and just say "It's
Joy, now with logical programming too!"  Or I could just use Joy as a
tool inside Prolog that helps with partial evaluation and efficiency (by
compiling to lower-level specialized code.)

I was convinced I would be maintaining my own fork of Python 2 (in the
wake of Python 3), but since playing with Prolog I've adopted a personal
rule, to wit:  Always use the /highest-level/ language you can, and only
"drop down" to a lower-level language when you really have to for some
reason.  Typically efficiency.  The other biggie being ease of
expression, but I think you should find ways to express your solutions in
a higher-level language.  Ways that are elegant and that translate
automatically to good low-level constructs (ASM or LLVM Intermediate
Representation or WebASM or wahtever.)

It turns out that there is a steady trickle of research into compiling
with Logical Paradigm compilers going right back to David Warren
[Warren1980].  The last chapter of "The Art of Prolog" is a presentation
of a compiler for a simple Pascal-like language.

I think I see a very interesting and viable replacement (for Python, for
me) in this setup:  Prolog+Joy+Compiler.  This gives you Logical
Paradigm, a superior Functional Paradigm interpreter, and a path to
Imperative Paradigm assembly code, in one elegant package.  It's
powerful, concise, expressive, ...I could just heap up the adjectives.

You can take a Joy expression, evaulate it in Prolog/Joy to figure out
e.g. how many variables it expects on the stack, then transfer the
expression to Python/Joy, preloading the stack with Sympy symbolic
variables, then evaluate again to get Sympy symbolic result objects.
Sympy can convert these into optimized low-level functions that can work
efficiently with e.g. Numpy arrays, etc.  I've tested this out and it
works fine.  It's simple "compilation" that I can do today and that gives
a pretty decent payoff "out of the box".

I'm really at the stage now where I'm filling in details and fleshing out
the UI and the applications.  I don't really need a compiler (yet) but
I'm probably going to work on it a bit more this week anyway.  I mostly
have to read up on the existing research and then just apply it.  Prolog
is so fucking elegant that it's easy to write this stuff once you get the
hang of it.  (I feel really stupid that it has taken me so long to get
back to Prolog.  A friend tried to turn me on to it like two decades ago.
Better late than never!)  Already writing code in ol' Python seems
hopelessly crude.  I feel like I've suddenly morphed into Dr. McCoy in
the "Save the Whales" Star Trek movie (#4, still the best IMHO.  Although
You can't beat Christopher Loyd's Klingon Captain Kral!) when he's in the
hospital.  "Dr. gave me a pill and I grew a new kidney!"


August 13
------------------------

This Prolog thing has thrown me for a bit of a loop.  It's a good one
though.

I have spent so much time with the Python version of Joy that it feels
weird to be so ready to basically abandon it.  This is driven in part by
the death of Python 2 and my antipathy towards Python 3.  I had thought I
would maintain my own fork of Py2 but it would also make sense to migrate
to an entirely different language/ecosystem.   If I have Prolog for the
Prologgy bits, and Joy for the imperative bits, and Prolog gives me a
viable path to the metal, then do I really need Py2 anymore?  Of course
I'd keep in for easy access to all the cool software already written for
it.  But part of the old Xerblin idea was to engulf and digest existing
software.

I want to stay in the logical paradigm as much as possible and only "drop
down" when necessary for efficiency or expressiveness.  (E.g. Dancing
Links and SEQUITUR algorithms.)  Even then it would be great to have
high-level descriptions that are then compiled to correct low-level code.
There are three methods of "compiling" I've identified so far:

1. Using an actual compiler written in Plg or Py2,
2. using Sympy to generate "lambdafied" versions of symbolic expressions,
3. and writing a Joy-to-Factor converter and using Factor-lang's native compilation
   facility.
   
Probably gonna wanna use all three plus some others.

I have a hunch that partial evaluation might work best in Joy, although
it might be superfluous if Plg delivers all the needful info
automatically already.

I have to re-evaluate my priorities and goals a little.  It feels a
little like Yak Shaving to spend the next week learning to write a
compiler in Prolog.  Do I really need it right now?  Plg partial
reduction using clause() is great and powerful, but I don't think the
efficiency of the Joy interpreter is an issue at the moment.  A
Joy-to-Factor translator written in Plg would probably be a much faster
route to native binary code, but rolling my own (compiler in Plg) would
take about as long and I would understand the output better and could re-target
 it to e.g. LLVM IR or WebASM.  I think a Joy-to-Python or
Joy-to-Cython compiler written in Plg would be better along a few
dimensions: more interesting and accessible to a larger audience, is that
it? I thought I had more.  Maybe Factor is the way to go?  Eventually
I'll do both but which, if either, is needed right now?

The other thing to work on would be the UI.  Evan C.'s Functional
Reactive Programming model seems perfect (Elm-lang.)


August 30
------------------------

I implemented an assembler for the Wirth RISC in Prolog.  It was
very easy, only took a few hours, mostly due to the simplicity of the
processor and its instruction set.  Having a parser already, I
implemented the first code-generation pattern from the Oberon compiler
chapter to kind of explore and see what it's like.  Again, with Prolog
this is relatively easy, so by the end of the day I had a "compiler" that
could handle variable allocation and assignment statements that consist
of assigning a constant value to a single (module-)global variable.

Already there were things that I don't necessarily want to deal with
right away, like encoding floats to/from binary, and dealing with
negative integers (Although I do handle branches to earlier labels so you
can jump backwards, i.e. loop.)  But it has let me grasp how compilers are
both such an extraordinary improvement on assemblers, yet also so lodged
in the past.  They enshrine decisions made in the dawn-time and so
encumber us today with misshapen abstractions that do more harm than good
now that Moore's law has rescued us from tiny machines (with tiny
machines.)


It's also led me to realize just how different the stack-based model of
Joy is from the quasi-Turing Machine of the RISC CPU.  For example, in
Joy branches and loops expect a Boolean value on the stack, while in the
RISC we instead have special "flag" bits in the chip which are un/set as
side-effects of e.g. subtraction, etc.  Implementing the Joy semantics
directly would mean copying out the flag bit(s) of interest to a register
(presumably the Top of Stack "cell" would be a register in any given Joy
implementation, although that's not strictly necessary) every for every
branch and loop iteration!  Bad for efficiency, eh?

This implies that any real Joy-to-ASM compiler should be able to "look
inside" the predicate of an ifte or while combinator to see which flags
are the ones to check rather than defining the Joy comparison ops to
actually reify the flag to a Boolean value on the stack.  This shouldn't
be too hard, but the tricky bit is that in Joy anything could leave a
Boolean for branch and loop combinators!  In practice, this may all be
moot:  The Prolog compiler will likely be able to "factor out" most of
the weirdness from any given, practically-useful, definition!

I already have a Joy-in-ASM interpreter for Wirth RISC that's very crude and incomplete
but functional  Writing enough "compiler" in Prolog
to regenerate that code should give me a good idea what I'm about.  And
there's a lot of Forth code and information around compiling Forth that
is useful.  By the end of the weekend I should have some Joy code that is
getting compiled to RISC ASM and drawing things in the framebuffer of the
simulator.