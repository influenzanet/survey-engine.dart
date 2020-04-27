const testSurveySingleItemResponseOne = {
  'key': 'G0.S1',
  'meta': {
    'position': -1,
    'localeCode': '',
    'rendered': [],
    'displayed': [],
    'responded': [],
  },
};
const testSurveySingleItemResponseTwo = {
  'key': 'G0.S2',
  'meta': {
    'position': -1,
    'localeCode': '',
    'rendered': [],
    'displayed': [],
    'responded': [],
  },
};
const testSurveySingleItemResponseThree = {
  'key': 'G0.G1.S3',
  'meta': {
    'position': -1,
    'localeCode': '',
    'rendered': [],
    'displayed': [],
    'responded': [],
  },
};

const testSurveyGroupItemResponseOne = {
  'key': 'G0.G1',
  'meta': {
    'position': -1,
    'localeCode': '',
    'version': 1,
    'rendered': [],
    'displayed': [],
    'responded': [],
  },
  'items': [testSurveySingleItemResponseThree]
};
const testSurveyGroupItemResponseRoot = {
  'key': 'G0',
  'meta': {
    'position': -1,
    'localeCode': '',
    'version': 1,
    'rendered': [],
    'displayed': [],
    'responded': [],
  },
  'items': [
    testSurveySingleItemResponseOne,
    testSurveySingleItemResponseTwo,
    testSurveyGroupItemResponseOne
  ]
};
const testSurveySingleItemOne = {
  'key': 'G0.S1',
  'follows': ['G0'],
  'type': 'basic.static.title',
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
  },
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
};
const testSurveySingleItemTwo = {
  'key': 'G0.S2',
  'type': 'basic.static.title',
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
  },
  'validations': [],
};
const testSurveySingleItemThree = {
  'key': 'G0.G1.S3',
  'type': 'basic.static.title',
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
  },
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
};
const testSurveyGroupItemOne = {
  'key': 'G0.G1',
  'condition': {
    'name': 'not',
    'returnType': 'boolean',
    'data': [
      {'dtype': 'str', 'str': ''}
    ]
  },
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
const renderedSurveyGroupRoot = {
  "key": "G0",
  "version": 1,
  "items": [
    {
      "key": "G0.S1",
      'follows': ['G0'],
      "type": "basic.static.title",
      "components": {
        "role": "root",
        "items": [
          {
            "role": "title",
            "content": [
              {
                "code": "en",
                "parts":
                    "What is the first part of your school/college/workplace postal code (where you spend the majority of your working/studying time)?"
              },
              {"code": "de", "parts": "XX"}
            ],
            "displayCondition": true,
            "disabled": false
          }
        ],
        "order": {"name": "sequential"}
      },
      "validations": [
        {"rule": true, "type": "soft", "key": "v1"}
      ]
    },
    {
      "key": "G0.S2",
      "type": "basic.static.title",
      "components": {
        "role": "root",
        "items": [
          {
            "role": "title",
            "content": [
              {"code": "en", "parts": "What is your main activity?"},
              {"code": "de", "parts": "Was ist Ihre Haupttätigkeit?"}
            ],
            "displayCondition": true,
            "disabled": false
          }
        ],
        "order": {"name": "sequential"}
      },
      "validations": [],
    },
    {
      "key": "G0.G1",
      'condition': {
        'name': 'not',
        'returnType': 'boolean',
        'data': [
          {'dtype': 'str', 'str': ''}
        ]
      },
      "version": 1,
      "items": [
        {
          "key": "G0.G1.S3",
          "type": "basic.static.title",
          "components": {
            "role": "root",
            "items": [
              {
                "role": "title",
                "content": [
                  {"code": "en", "parts": "What is your occupation?"},
                  {"code": "de", "parts": "XX"}
                ],
                "displayCondition": true,
                "disabled": false
              }
            ],
            "order": {"name": "sequential"}
          },
          "validations": [
            {"rule": true, "type": "soft", "key": "v1"}
          ],
        }
      ],
    }
  ],
};
const List flatResponseItems = [
  {
    'key': 'G0.S1',
    'meta': {
      'position': -1,
      'localeCode': '',
      'rendered': [],
      'displayed': [],
      'responded': [],
    }
  },
  {
    'key': 'G0.S2',
    'meta': {
      'position': -1,
      'localeCode': '',
      'rendered': [],
      'displayed': [],
      'responded': [],
    }
  },
  {
    'key': 'G0.G1.S3',
    'meta': {
      'position': -1,
      'localeCode': '',
      'rendered': [],
      'displayed': [],
      'responded': [],
    }
  }
];

const List flatRenderedItems = [
  {
    "key": "G0.S1",
    'follows': ['G0'],
    "type": "basic.static.title",
    "components": {
      "role": "root",
      "items": [
        {
          "role": "title",
          "content": [
            {
              "code": "en",
              "parts":
                  "What is the first part of your school/college/workplace postal code (where you spend the majority of your working/studying time)?"
            },
            {"code": "de", "parts": "XX"}
          ],
          "displayCondition": true,
          "disabled": false
        }
      ],
      "order": {"name": "sequential"}
    },
    "validations": [
      {"rule": true, "type": "soft", "key": "v1"}
    ]
  },
  {
    "key": "G0.S2",
    "type": "basic.static.title",
    "components": {
      "role": "root",
      "items": [
        {
          "role": "title",
          "content": [
            {"code": "en", "parts": "What is your main activity?"},
            {"code": "de", "parts": "Was ist Ihre Haupttätigkeit?"}
          ],
          "displayCondition": true,
          "disabled": false
        }
      ],
      "order": {"name": "sequential"}
    },
    "validations": [],
  },
  {
    "key": "G0.G1.S3",
    "type": "basic.static.title",
    "components": {
      "role": "root",
      "items": [
        {
          "role": "title",
          "content": [
            {"code": "en", "parts": "What is your occupation?"},
            {"code": "de", "parts": "XX"}
          ],
          "displayCondition": true,
          "disabled": false
        }
      ],
      "order": {"name": "sequential"}
    },
    "validations": [
      {"rule": true, "type": "soft", "key": "v1"}
    ],
  }
];
