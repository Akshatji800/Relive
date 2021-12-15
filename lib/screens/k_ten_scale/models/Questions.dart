class Question {
  final int id, answer;
  final String question;
  final List<String> options;

  Question({required this.id, required this.question, required this.answer, required this.options});
}

const List sample_data = [
  {
    "id": 1,
    "question":
        "In the past 4 weeks, about how often did you feel tired out for no good reason? ",
    "options": ['All of the time', 'Most of the time', 'Some of the time', 'A little of the time', 'None of the time'],
    "answer_index": 1,
  },
  {
    "id": 2,
    "question": "In the past 4 weeks, about how often did you feel nervous? ",
    "options": ['All of the time', 'Most of the time', 'Some of the time', 'A little of the time', 'None of the time'],
    "answer_index": 2,
  },
  {
    "id": 3,
    "question": "In the past 4 weeks, about how often did you feel so nervous that nothing could calm you down?",
    "options": ['All of the time', 'Most of the time', 'Some of the time', 'A little of the time', 'None of the time'],
    "answer_index": 2,
  },
  {
    "id": 4,
    "question": "In the past 4 weeks, about how often did you feel hopeless? ",
    "options": ['All of the time', 'Most of the time', 'Some of the time', 'A little of the time', 'None of the time'],
    "answer_index": 2,
  },
  {
    "id": 5,
    "question": "In the past 4 weeks, about how often did you feel restless or fidgety?",
    "options": ['All of the time', 'Most of the time', 'Some of the time', 'A little of the time', 'None of the time'],
    "answer_index": 2,
  },
  {
    "id": 6,
    "question": "In the past 4 weeks, about how often did you feel so restless you could not sit still?",
    "options": ['All of the time', 'Most of the time', 'Some of the time', 'A little of the time', 'None of the time'],
    "answer_index": 2,
  },
  {
    "id": 7,
    "question": "In the past 4 weeks, about how often did you feel depressed? ",
    "options": ['All of the time', 'Most of the time', 'Some of the time', 'A little of the time', 'None of the time'],
    "answer_index": 2,
  },
  {
    "id": 8,
    "question": "In the past 4 weeks, about how often did you feel that everything was an effort?  ",
    "options": ['All of the time', 'Most of the time', 'Some of the time', 'A little of the time', 'None of the time'],
    "answer_index": 2,
  },
  {
    "id": 9,
    "question": "In the past 4 weeks, about how often did you feel so sad that nothing could cheer you up? ",
    "options": ['All of the time', 'Most of the time', 'Some of the time', 'A little of the time', 'None of the time'],
    "answer_index": 2,
  },
  {
    "id": 10,
    "question": "In the past 4 weeks, about how often did you feel worthless? ",
    "options": ['All of the time', 'Most of the time', 'Some of the time', 'A little of the time', 'None of the time'],
    "answer_index": 2,
  },
];
