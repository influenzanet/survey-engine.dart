const testSurveySingleItemOne = {
  'key': 'G0.S1',
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
  'key': 'G0.S2',
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
const testSurveySingleItemThree = {
  'key': 'G0.G1.S3',
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
              {"str": "What is your occupation?"}
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
const testSurveyGroupItemOne = {
  'key': 'G0.G1',
  'version': 1,
  'items': [testSurveySingleItemThree]
};
const testSurveyGroupItemRoot = {
  'key': 'G0',
  'version': 1,
  'items': [
    testSurveySingleItemOne,
    testSurveySingleItemTwo,
    testSurveyGroupItemOne
  ]
};
