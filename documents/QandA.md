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
   + Answer: `temporaryItem` allows to have a reference to a survey item not pushed to the "survey tree" yet. Currently the objective is that we can resolve "this" and so making a shortcut to the current item - useful in case, we are referring to validations of the survey item in a displayCondition. When "rendering/resolving" an item, we have to do it step by step, and in between these steps the result is not pushed to the survey tree - so later in the pipeline, this is the only way to access the "temporary results".
2. **getContext**: How does it function? What is a `profile` and `mode`
   + Answer: context is a data object, the engine should get from the client app it is running in. It can contain different infos, but this part has still to be defined properly, what attributes will be necessary. But the method getContext, is simple the getter, which returns the context attribute's value. `mode` is currently used to define a test string - like `mode = "test"`

## Selection method
1. **Expression**: Selection method is of type `expression` having three cases of `uniform`,`highestPriority` and `exponential` as expression names. All the three have no `returnType`, considering evaluation of the selection method expression, should it just return a `SurveyGroupItem` object?
 + Answer: `temporaryItem` allows to have a reference to a survey item not pushed to the "survey tree" yet. Currently the objective is that we can resolve "this" and so making a shortcut to the current item - useful in case, we are referring to validations of the survey item in a displayCondition. When "rendering/resolving" an item, we have to do it step by step, and in between these steps the result is not pushed to the survey tree - so later in the pipeline, this is the only way to access the "temporary results".

2. **exponential**: Does `exponentialRandomSelector` some kind of standard logic to pick an item? If yes is there any available documentation for it?
+ Answer: This is a random selection, where the distribution looks something like this: https://en.wikipedia.org/wiki/Exponential_distribution
Where items with higher priorioty value are more likely to be picked but they don't have to be picked first. 


## Engine.ts
1. **initResponseObject**: Is there any specific reason as to why `position=-1` and timestamp an `string` instead of an array of `int`?
   + Answer: Yes `position` will be incremented as `0` is the initial position. and `timestamp` is a 64 bit `Integer` so one can use dart `int`
2. **addRenderedItem**: 
   1. Why does it return an `atPosition` despite not being used anywhere else?
   + Answer: Yes `atPosition` return can be removed __Mention it in comments__
   2. The required functions to be implemented for implementing this are **initResponseObject**->**constructor**->**findresponseItem**->**setTimestampFor**
   + Answer: Use a flowchart and get it reviewed.
3. **initRenderedGroup**
4. **reRenderGroup**
5. **getNextItem**
6. **findSurveyDefItem**
7. **findRenderedItem**
8. **findResponseItem**: A naming convention is followed for naming SurveyGroupItem and SurveySingleItem keys but does it follow a hierarchy  
eg:
if `GROUP1` has `GROUP2` and `SINGLE` as items.
`GROUP2` has `SINGLE2` as items
will the keys of `SINGLE2` item be `GROUP2.SINGLE2` or `GROUP1.GROUP2.SINGLE2`?
+ Answer: Yes but model is changed in later versions of `0.6.0`
9. **setTimeStampFor**: Should `timestamp` be punched on each `ResponseItem` whether `single` or `group`. If we punch `timestamp` just to a group would not that be enough? 


Independent functions
1. **resolveContent** : Resolves content and description of Localised objects
2. **evaluateBooleanresult**: Converts any expression result to a `boolean` type used especially for evaluating `displayConditon` in `ItemComponent`
3. **resolveItemComponentGroup**: Resolved Item Component group to a map
4. **renderSurveySingleItem**: Renders SingleSurveyItem

## LocalisedObject
1. **description**: Why can't description have a `code`?.
   + Answer: Description can have `code` as it is a child class of `LocalisedObject`. 






 
  
