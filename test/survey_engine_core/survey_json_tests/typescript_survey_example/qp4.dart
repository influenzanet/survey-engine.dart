const qp4 = {
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
          "validations": [],
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
                      {"str": "What is your main activity?"}
                    ]
                  },
                  {
                    "code": "de",
                    "parts": [
                      {"str": "XX"}
                    ]
                  }
                ]
              },
              {
                "key": "RG1",
                "role": "responseGroup",
                "order": {"name": "sequential"},
                "items": [
                  {
                    "key": "RG1.R1",
                    "role": "responseOption",
                    "content": [
                      {
                        "code": "en",
                        "parts": [
                          {"str": "Paid employment, full-time"}
                        ]
                      },
                      {
                        "code": "de",
                        "parts": [
                          {"str": "XX"}
                        ]
                      }
                    ]
                  },
                  {
                    "key": "RG1.R2",
                    "role": "responseOption",
                    "content": [
                      {
                        "code": "en",
                        "parts": [
                          {"str": "Paid employment, part-time?"}
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
            ]
          }
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
                          {"str": "QG0.QG4.Q4"},
                          {"str": "RG1.R1"}
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
                          {"str": "QG0.QG4.Q4"},
                          {"str": "RG1.R2"}
                        ]
                      }
                    }
                  ]
                }
              }
            ]
          },
          "version": 1,
          "validations": [],
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
              },
              {
                "key": "RG1",
                "role": "responseGroup",
                "order": {"name": "sequential"},
                "items": [
                  {"key": "RG1.R1", "role": "userInput"},
                  {
                    "key": "RG1.R2",
                    "role": "responseOption",
                    "content": [
                      {
                        "code": "en",
                        "parts": [
                          {"str": "I don’t know/can’t remember"}
                        ]
                      },
                      {
                        "code": "de",
                        "parts": [
                          {"str": "XX"}
                        ]
                      }
                    ]
                  },
                  {
                    "key": "RG1.R3",
                    "role": "responseOption",
                    "content": [
                      {
                        "code": "en",
                        "parts": [
                          {
                            "str":
                                "Not applicable (e.g. don’t have a fixed workplace)"
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
            ]
          }
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
                          {"str": "QG0.QG4.Q4"},
                          {"str": "RG1.R1"}
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
                          {"str": "QG0.QG4.Q4"},
                          {"str": "RG1.R2"}
                        ]
                      }
                    }
                  ]
                }
              }
            ]
          },
          "version": 1,
          "validations": [],
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
                        "str":
                            "Which of the following descriptions most closely matches with your main occupation?"
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
              },
              {
                "key": "RG1",
                "role": "responseGroup",
                "order": {"name": "sequential"},
                "items": [
                  {
                    "key": "RG1.R1",
                    "role": "responseOption",
                    "content": [
                      {
                        "code": "en",
                        "parts": [
                          {
                            "str":
                                "Professional (e.g. manager, doctor, teacher, nurse, engineer)"
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
                  },
                  {
                    "key": "RG1.R2",
                    "role": "userInput",
                    "content": [
                      {
                        "code": "en",
                        "parts": [
                          {"str": "Other"}
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
            ]
          }
        }
      ]
    }
  ]
};
