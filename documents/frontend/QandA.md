# Queries

## General

1. **Page**: How many questions are to be displayed on page? 
   + Ans: Read the wiki and code to analyse the page view
2. **TextInput**: For other input widgets the components are rerendered after a button press like radio change/checkbox press. How is it handled for text form field. is it triggered after the next button press? 
   + Ans: A timer is started when text change is triggered and the data is recorded after a certain duration
3. **Language Switcher**: How is language switcher taken care of in the web-client?. What language `code` should be used by default?
   + Ans: The user model containes an attribute like “preferredLanguage” - the actual language selection and changing is not finalized yet, we just have a placeholder dropdown for testing it
4. **Multiple response groups**: I observed two drop-down groups for one question in a data set on web-client. Can there be `multiple` response groups present for a single question?. eg:(two single choice groups for one question). 
   + Ans: yes, it is possible, but not very common - the root response component could include multiple response groups in theory or also some text between them