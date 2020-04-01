const testSurveySingleItemOne = {
  'key': 'q1',
  'type': 'basic.static.title',
  'validations': [
    {
      'type': 'soft',
      'key': 'v1',
      'rule': {
        'name': 'or',
        'data': [
          {'dtype': 'num', 'num': 2},
          {'dtype': 'num', 'num': 1}
        ]
      }
    },
  ],
  'components': {
    "role": "root",
    "items": [
      {
        "role": "title",
        "content": [
          {
            "code": "en",
            "parts": [
              {
                "str":
                    "What is the first part of your school/college/workplace postal code (where you spend the majority of your working/studying time)?"
              }
            ]
          },
          {
            "code": "de",
            "parts": [
              {"str": "XX"}
            ]
          }
        ]
      }
    ]
  }
};
const testSurveySingleItemTwo = {
  'key': 'q2',
  'type': 'basic.static.title',
  'version': 1,
  'validations': [],
  'components': {
    'role': 'root',
    'items': [
      {
        'role': 'title',
        'content': [
          {
            'code': 'en',
            'parts': [
              {'str': 'What is your main activity?'},
            ]
          },
          {
            'code': 'de',
            'parts': [
              {'str': 'Was ist Ihre Haupttätigkeit?'},
            ]
          },
        ]
      },
    ]
  }
};
const testSurveyGroupItemOne = {
  'key': 'grp1',
  'version': 1,
  'items': [testSurveySingleItemOne]
};
const testSurveyGroupItemResult = {
  'key': 'res',
  'version': 1,
  'items': [
    testSurveySingleItemOne,
    testSurveySingleItemTwo,
    testSurveyGroupItemOne
  ]
};
