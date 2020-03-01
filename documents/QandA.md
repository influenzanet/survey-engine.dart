# Queries

## LocalisedObject

1. **parts**: returns the actual string/object to be displayed in the content.
   1. Why is it an array of strings though only it has one `str` element
   + Ans: It can be an array of strings and expression but it should return a string and finally only one str is present

## Display Component

1. **disabled**: Can DisplayComponent be disabled?
   + Ans: No 
2. **displayCondtion**: Should condition be evaluated first? If true then can `content` be disabled
   + Ans: Do not disable any content as it just should not be displayed in UI
3. **style**: Can `styles` be focussed after completing the backend engine?
   + Ans: Yes

## Response Component
1. **dtype and properties**: An example (JSON) as `dtype` and `properties` examples are not found in reference/test JSON file.

## Item Component

1. **role**: defines the basic element type of a HTML Tag. I am assuming a `root` role is used as a root element of react app. How does role=`hint` work?
   + Answer
2. **content**: defined the actual inner HTML content to be displayed
   + Comment
3. **description**: Does it signify metadata?
   + Answer
4. **disabled**: The HTML element(whole Item Component) will be disabled if respective `Expression` is evaluated to `true`
   + Answer
5. **style**: defines CSS styles for the element
   + Answer
6. **key**: What does it signify?
   + Answer
7. **group component**: Evaluates to a group of **item components** for eg:
    ```html
   <ul>
   <li></li>
   ...
   </ul> 
   ```
   + Comment
8. **Response Component** and **Display Component**: How does it work?
   + Answer