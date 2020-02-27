# Queries

## LocalisedObject

1. **parts**: returns the actual string/object to be displayed in the content.
   1. Why is it an array of strings though only it has one `str` element
   + Ans:
   2. In case of `exp`, should the `name` of `exp` be evaluated to an `str` value and returned?
   + Ans:

## Display Component

1. **disabled**: Can DisplayComponent be disabled?
   + Ans:
2. **displayCondtion**: Should condition be evaluated first? If true then can `content` be disabled?
   + Ans:
3. **style**: Can `styles` be focussed after completing the backend engine?
   + Ans:

## Item Component

1. **role**: defines the basic element type of a HTML Tag. I am assuming a `root` role is used as a root element of react app. How does role=`hint` work?
   + Answer
2. **content**: defined the actual inner HTML content to be displayed
   + Comment
3. **description**: Does it signify metadata?
   + Answer
4. **disabled**: The HTML element(whole Item Component) will be disabled if respective `Expression` is evaluated to `true`
   + Answer
5. **dtyle**: defines CSS styles for the element
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