const conv = {
  "key": "QG0",
  "version": 1,
  "items": [
    {
      "key": "QG0.QG4",
      "version": 1,
      "items": [
        {
          "key": "QG0.QG4.Q4",
          "version": 1,
          "type": "basic.input.single-choice",
          "components": {
            "role": "root",
            "items": [
              {
                "role": "title",
                "content": [
                  {
                    "code": "en",
                    "parts": [
                      {"dtype": "str", "str": "What is your main activity?"}
                    ]
                  },
                  {
                    "code": "de",
                    "parts": [
                      {"dtype": "str", "str": "XX"}
                    ]
                  }
                ]
              },
              {
                "role": "responseGroup",
                "key": "RG1",
                "items": [
                  {
                    "role": "responseOption",
                    "content": [
                      {
                        "code": "en",
                        "parts": [
                          {"dtype": "str", "str": "Paid employment, full-time"}
                        ]
                      },
                      {
                        "code": "de",
                        "parts": [
                          {"dtype": "str", "str": "XX"}
                        ]
                      }
                    ],
                    "key": "RG1.R1",
                  },
                  {
                    "role": "responseOption",
                    "content": [
                      {
                        "code": "en",
                        "parts": [
                          {"dtype": "str", "str": "Paid employment, part-time?"}
                        ]
                      },
                      {
                        "code": "de",
                        "parts": [
                          {"dtype": "str", "str": "XX"}
                        ]
                      }
                    ],
                    "key": "RG1.R2",
                  }
                ],
                "order": {"name": "sequential"}
              }
            ],
            "order": {"name": "sequential"}
          },
          "validations": []
        },
        {
          "key": "QG0.QG4.Q4b",
          "condition": {
            "name": "or",
            "data": [
              {
                "dtype": "exp",
                "exp": {
                  "name": "isDefined",
                  "data": [
                    {
                      "dtype": "exp",
                      "exp": {
                        "name": "getResponseItem",
                        "data": [
                          {"dtype": "str", "str": "QG0.QG4.Q4"},
                          {"dtype": "str", "str": "RG1.R1"}
                        ]
                      }
                    }
                  ]
                }
              },
              {
                "dtype": "exp",
                "exp": {
                  "name": "isDefined",
                  "data": [
                    {
                      "dtype": "exp",
                      "exp": {
                        "name": "getResponseItem",
                        "data": [
                          {"dtype": "str", "str": "QG0.QG4.Q4"},
                          {"dtype": "str", "str": "RG1.R2"}
                        ]
                      }
                    }
                  ]
                }
              }
            ]
          },
          "version": 1,
          "type": "basic.input.single-choice",
          "components": {
            "role": "root",
            "items": [
              {
                "role": "title",
                "content": [
                  {
                    "code": "en",
                    "parts": [
                      {
                        "dtype": "str",
                        "str":
                            "What is the first part of your school/college/workplace postal code (where you spend the majority of your working/studying time)?"
                      }
                    ]
                  },
                  {
                    "code": "de",
                    "parts": [
                      {"dtype": "str", "str": "XX"}
                    ]
                  }
                ]
              },
              {
                "role": "responseGroup",
                "key": "RG1",
                "items": [
                  {
                    "role": "userInput",
                    "key": "RG1.R1",
                  },
                  {
                    "role": "responseOption",
                    "content": [
                      {
                        "code": "en",
                        "parts": [
                          {"dtype": "str", "str": "I don’t know/can’t remember"}
                        ]
                      },
                      {
                        "code": "de",
                        "parts": [
                          {"dtype": "str", "str": "XX"}
                        ]
                      }
                    ],
                    "key": "RG1.R2",
                  },
                  {
                    "role": "responseOption",
                    "content": [
                      {
                        "code": "en",
                        "parts": [
                          {
                            "dtype": "str",
                            "str":
                                "Not applicable (e.g. don’t have a fixed workplace)"
                          }
                        ]
                      },
                      {
                        "code": "de",
                        "parts": [
                          {"dtype": "str", "str": "XX"}
                        ]
                      }
                    ],
                    "key": "RG1.R3",
                  }
                ],
                "order": {"name": "sequential"}
              }
            ],
            "order": {"name": "sequential"}
          },
          "validations": []
        },
        {
          "key": "QG0.QG4.Q4c",
          "condition": {
            "name": "or",
            "data": [
              {
                "dtype": "exp",
                "exp": {
                  "name": "isDefined",
                  "data": [
                    {
                      "dtype": "exp",
                      "exp": {
                        "name": "getResponseItem",
                        "data": [
                          {"dtype": "str", "str": "QG0.QG4.Q4"},
                          {"dtype": "str", "str": "RG1.R1"}
                        ]
                      }
                    }
                  ]
                }
              },
              {
                "dtype": "exp",
                "exp": {
                  "name": "isDefined",
                  "data": [
                    {
                      "dtype": "exp",
                      "exp": {
                        "name": "getResponseItem",
                        "data": [
                          {"dtype": "str", "str": "QG0.QG4.Q4"},
                          {"dtype": "str", "str": "RG1.R2"}
                        ]
                      }
                    }
                  ]
                }
              }
            ]
          },
          "version": 1,
          "type": "basic.input.single-choice",
          "components": {
            "role": "root",
            "items": [
              {
                "role": "title",
                "content": [
                  {
                    "code": "en",
                    "parts": [
                      {
                        "dtype": "str",
                        "str":
                            "Which of the following descriptions most closely matches with your main occupation?"
                      }
                    ]
                  },
                  {
                    "code": "de",
                    "parts": [
                      {"dtype": "str", "str": "XX"}
                    ]
                  }
                ]
              },
              {
                "role": "responseGroup",
                "key": "RG1",
                "items": [
                  {
                    "role": "responseOption",
                    "content": [
                      {
                        "code": "en",
                        "parts": [
                          {
                            "dtype": "str",
                            "str":
                                "Professional (e.g. manager, doctor, teacher, nurse, engineer)"
                          }
                        ]
                      },
                      {
                        "code": "de",
                        "parts": [
                          {"dtype": "str", "str": "XX"}
                        ]
                      }
                    ],
                    "key": "RG1.R1",
                  },
                  {
                    "role": "userInput",
                    "content": [
                      {
                        "code": "en",
                        "parts": [
                          {"dtype": "str", "str": "Other"}
                        ]
                      },
                      {
                        "code": "de",
                        "parts": [
                          {"dtype": "str", "str": "XX"}
                        ]
                      }
                    ],
                    "key": "RG1.R2",
                  }
                ],
                "order": {"name": "sequential"}
              }
            ],
            "order": {"name": "sequential"}
          },
          "validations": []
        }
      ]
    }
  ]
};
