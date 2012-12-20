# NSXMLParser Demonstration

--

## Introduction

This is an iOS application, created in response to [Parsing XML data with NSXMLParser](http://wiki.cs.unh.edu/wiki/index.php/Parsing_XML_data_with_NSXMLParser). This project embodies two implementations, a modified version of the code included in the "Parsing XML data with NSXMLParser" web page, as well as a generic rendition which (IMHO) offers greater reuse possibilities.

### Issues

Unfortunately, this code of the "Parsing XML data with NSXMLParser" site suffers from a number of issues:

- it was not using ARC;

- it had explicit instance variable (ivar) definitions which are now generally discouraged; one should generally let the `@synthesize` statement generate those ivars for you as discussed in [Naming Properties and Data Types](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CodingGuidelines/Articles/NamingIvarsAndTypes.html#//apple_ref/doc/uid/20001284-BAJGIIJE) of the Apple _Coding Guidelines for Cocoa;_

- it was using the same name for the ivar as it was for the properties, which is now discouraged; [nowadays it is recommended that the ivar's name begin with an underscore](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CodingGuidelines/Articles/NamingIvarsAndTypes.html#//apple_ref/doc/uid/20001284-BAJGIIJE); in contemporary versions of Xcode, when the `@synthesize` statement is omitted, it will automatically generate the ivar with the leading underscore;

- in several cases, the property was being accessed directly through the ivar, where as it is now recommended to use the property's setter accessor method rather than the ivar, [at least when setting the value](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/MemoryMgmt/Articles/mmPractical.html#//apple_ref/doc/uid/TP40004447-SW5);

- the code was missing the declaration for the `currentElementValue` property;

- the code had properties that were really implementation-specific declared in the public interface of the .h; these have been moved out of the public interface and in to the private class extension in the .m;

- the `XMLParser` was designated as conforming to `NSXMLParserDelegate`

- I have renamed `initXmlParser` to `init` and have employed a more conventional implementation for it;

- I have renamed the entire `XMLParser` class to `UserParser` because it's not a generic parser, but rather has been coded to handle this one particular XML format, so the name should reflect that very specific usage;

- There was a bug in `foundCharacters` in which characters between the element names were being added to the next element's value.

### Reuse

Personally, on top of all of those issues, I find it frustrating that the `XMLParser` class on that web site (renamed `UsersParser` here) was coded for only the `User` XML data. So, I have written a variation of it, `XmlArrayParser`, which captures much of the functionality of the original parser code, but can work with most XML files of this structure (i.e. an array of items, for which each item has either a series of attributes or a series of sub-elements that are strings). In short, while this `XmlArrayParser` has limitations, it does everything that the `XmlParser` was doing, plus a little more, and does so in a more flexible fashion, so you can get some reuse from it.

## Classes, Protocols, and Categories

### Standard classes

The classes in this project include:

- `AppDelegate` - the standard app delegate class.

- `ViewController` - a simple view controller with `IBAction` methods for two buttons. One to parse using the "User Parser", the original `XmlParser` from the web site. The second to parse using the generic parser. Please refer to the `IBAction` methods in this `ViewController` class to understand how to invoke the parsing process for each..

### Classes taken from "Parsing XML data with NSXMLParser

- `User` - This is a simple `NSObject` with three properties. There is only one method, and that's a `description` method to facilitate the `NSLog`ing of the results.

- `UsersParser` - This was called `XmlParser` in the code listed in "Parsing XML data with NSXMLParser". This is not really the parser itself, but rather the delegate object that will be passed to the parser, which will receive the `NSXmlParserDelegate` call back methods. It reads the XML and stores the results as an array of `User` objects. Frankly, I struggle with having "Parser" in the name at all, because it seems counter intuitive for the calling routine to need both a `NSXMLParser` as well as a `UsersParser`. Perhaps this should be called a "parser handler", "parser delegate class" or something like that. In my approach, below, I cut the gordian knot, encapsulating the `NSXMLParser` within another class, in which case, the "parser" nomenclature is no longer confusing.

### Flexible XML Parser

- `XmlArrayParser` - This class is also a very simple parser, but it encapsulates `NSXMLParser` so the caller doesn't have to deal with two objects at all. It also stores the results in an array of dictionary entries, so it doesn't need to know the structure of the data. All it needs is (a) what element name designates a new row of data (`user` in our example); (b) what attributes do we want to capture for this element (in our revised example below, this would be `userId`); and (c) what sub-elements doe we want to capture values for (e.g. `userName`, `firstName` and `lastName`).

## XML Data

The purpose of this app is to parse XML data. Here is the XML data used by this app:

    <users>
        <user userId="101">
            <userName>mspeller</userName>
            <firstName>Mike</firstName>
            <lastName>Speller</lastName>
        </user>
        <user userId="102">
            <userName>mgdan</userName>
            <firstName>Mila</firstName>
            <lastName>Gdan</lastName>
        </user>
        <user userId="103">
            <userName>rryan</userName>
            <firstName>Robert</firstName>
            <lastName>Ryan</lastName>
        </user>
    </users>

While you can obviously retrieve XML from any source you want, this app includes the XML in the bundle and reads it from there.

## References

- [NSXMLParser samples and ARC](http://stackoverflow.com/questions/13964968).

- [How To Choose The Best XML Parser for Your iPhone Project](http://www.raywenderlich.com/553/how-to-chose-the-best-xml-parser-for-your-iphone-project) is an article on Ray Wenderlich's site that walks through some considerations when choosing an XML parser for you iOS app.

## Notes

This was developed using Xcode 4.5.2 for devices running iOS 5 or later.

## Contact information

If you have any questions, do not hesitate to contact me at:

Rob Ryan
robert.ryan@mindspring.com

19 December 2012
