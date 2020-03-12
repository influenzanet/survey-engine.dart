# Queries

## Packaging of libraries

1. **Library**: Should the library be a dart package or flutter plugin?
   + Ans: The baeline needs to be a dart package. On top of that a flutter rendering needs to be set which later can be reused. All `survey components` logic must be written as a dart package as a primary task.

## Survey Item

1. **validations**: What are `hard` and `soft` validations
   + Ans: `hard` validation ensures that a `submit` button or a fetch next `item component` is disabled if the validation is `False`. `soft` validation does not disable any component but can throw an `error` or `description` message. They are mostly used in rendering. The `flutter engine` on top of the dart package needs to take care of that.
   
2. **order**: How does it work?
    + Ans: As the name suggests `sequential`,`random` and `random seed`. The `random` is yet not implemented in the survey engine yet. 
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
2. **content**: defined the actual inner HTML content to be displayed
3. **description**: Does it signify metadata?
4. **disabled**: The HTML element(whole Item Component) will be disabled if respective `Expression` is evaluated to `true`
5. **style**: defines CSS styles for the element
6. **key**: What does it signify?
7. **group component**: Evaluates to a group of **item components** for eg:
    ```html
   <ul>
   <li></li>
   ...
   </ul> 
   ```
8. **Response Component** and **Display Component**: How does it work?

+ Answer: Refer [Wiki of survey-engine.ts](https://github.com/influenzanet/survey-engine.ts/wiki/Components-of-a-survey-item#components-of-a-survey-item)

## Expression evaluation
1. **getAttribute**: What is `temporaryItem` ?
   + Answer:
2. **getContext**: How does it function? What is a `profile` and `mode`
   + Answer: 

## Selection method
1. **Expression**: Selection method is of type `expression` having three cases of `uniform`,`highestPriority` and `exponential` as expression names. All the three have no `returnType`, considering evaluation of the selection method expression, should it just return a `SurveyGroupItem` object?
 + Answer:
2. **exponential**: Does `exponentialRandomSelector` some kind of standard logic to pick an item? If yes is there any available documentation for it?

 
  
