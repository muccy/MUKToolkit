MUKToolkit
===========
MUKToolkit is an iOS framework which exposes some useful methods.

I decided not to use Objective-C categories in order not to pollute *system classes* namespaces and not to conflict with other frameworks you link.

Requirements
------------
* ARC enabled compiler
* Deployment target: iOS 4.3 or greater
* Base SDK: iOS 6 or greater
* Xcode 4.5 or greater

Installation
------------
*Thanks to [jverkoey iOS Framework]*.

#### Step 0: clone project from GitHub

#### Step 1: add MUKToolkit to your project
Drag or *Add To Files...* `MUKToolkit.xcodeproj` to your project.

<img src="http://i.imgur.com/3Fi7C.png" />

Please remember not to create a copy of files while adding project: you only need a reference to it.

<img src="http://i.imgur.com/IJRQo.png" />


#### Step 2: make your project dependent
Click on your project and, then, your app target:

<img src="http://i.imgur.com/IHlI9.png" />

Add dependency clicking on + button in *Target Dependencies* pane and choosing static library target (`MUKToolkit`):

<img src="http://i.imgur.com/IxWDh.png" />

Link your project clicking on + button in *Link binary with Libraries* pane and choosing static library product (`libMUKToolkit.a`):

<img src="http://i.imgur.com/ckS3l.png" />

Your project, now, should be like this:

<img src="http://i.imgur.com/CHYZB.png" />

#### Step 3: link required frameworks
You need to link those framework in order to support `MUKToolkit`:

* `Foundation`
* `UIKit`
* `CoreGraphics`
* `Security`

To do so you only need to click on + button in *Link binary with Libraries* pane and you can choose them.

<img src="http://i.imgur.com/SVoud.png" />

#### Step 4: load categories
In order to load every method in `MUKToolkit` you need to insert `-ObjC` flag to `Other Linker Flags` in *Build Settings* of your project.

<img src="http://i.imgur.com/fi8S0.png" /> 


#### Step 5: import headers
You only need to write `#import <MUKToolkit/MUKToolkit.h>` when you need headers.
You can also import `MUKToolkit` headers in your `pch` file:

<img src="http://i.imgur.com/ceOPm.png" />


Documentation
-------------
Build `MUKToolkitDocumentation` target in order to install documentation in Xcode.

*Requirement*: [appledoc] awesome project.

*TODO*: online documentation.



License
-------
Copyright (c) 2012, Marco Muccinelli
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright
notice, this list of conditions and the following disclaimer.
* Redistributions in binary form must reproduce the above copyright
notice, this list of conditions and the following disclaimer in the
documentation and/or other materials provided with the distribution.
* Neither the name of the <organization> nor the
names of its contributors may be used to endorse or promote products
derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.



[jverkoey iOS Framework]: https://github.com/jverkoey/iOS-Framework
[appledoc]: https://github.com/tomaz/appledoc
    