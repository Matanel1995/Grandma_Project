import 'package:flutter/material.dart';

import './models/category.dart';
import 'models/activity.dart';

const DUMMY_CATEGORIES = [
  Category(
    id: 'c1',
    title: 'Kids Time',
    color: Colors.purple,
  ),
  Category(
    id: 'c2',
    title: 'Go out To a Coffee Shop',
    color: Colors.red,
  ),
  Category(
    id: 'c3',
    title: 'Help Grandma With Shopping',
    color: Colors.orange,
  ),
  // colors
  // Colors.amber,
  //Colors.blue,
  //Colors.green,
  //Colors.lightBlue,
  //Colors.lightGreen,
  //Colors.pink,
  //Colors.teal,
  //
  // Category(
  //   id: 'c4',
  //   title: 'German',
  //   color: Colors.amber,
  // ),
  // Category(
  //   id: 'c5',
  //   title: 'Light & Lovely',
  //   color: Colors.blue,
  // ),
  // Category(
  //   id: 'c6',
  //   title: 'Exotic',
  //   color: Colors.green,
  // ),
  // Category(
  //   id: 'c7',
  //   title: 'Breakfast',
  //   color: Colors.lightBlue,
  // ),
  // Category(
  //   id: 'c8',
  //   title: 'Asian',
  //   color: Colors.lightGreen,
  // ),
  // Category(
  //   id: 'c9',
  //   title: 'French',
  //   color: Colors.pink,
  // ),
  // // Category(
  // //   id: 'c10',
  // //   title: 'Summer',
  // //   color: Colors.teal,
  // // ),
];

const DUMMY_ACTIVITIES = [
  Activity(
      id: 'm1',
      categories: [
        'c1',
      ],
      title: 'Kids Time',
      urgency: Urgency.Low,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Grandparents-1969824.jpg/640px-Grandparents-1969824.jpg',
      duration: 90,
      requierd: [
        'Schedule with grandma.',
        'Bring your kids!',
        'Car - to drop off your kids.',
        'Plan something for yourself!',
      ],
      importance: [
        'Grandma loves her time with the kids.',
        'It makes her so happy!.',
        'Time for yourself is also very important.',
        'The kids love their time with grandma.',
        'It is important that the kids will spent time with grandma.',
      ],
      score: 15),
  Activity(
      id: 'm2',
      categories: [
        'c2',
      ],
      title: 'Go out to a coffee shop.',
      urgency: Urgency.Medium,
      imageUrl:
          'https://thumbs.dreamstime.com/z/grandma-daughter-granddaughter-resting-street-cafe-sitting-drink-different-drinks-communicate-casually-226163551.jpg',
      duration: 90,
      requierd: [
        'Schedule with grandma.',
        'Reserve a good place!',
        'Come hungry!',
        'Pick up Grandma and take her back.',
      ],
      importance: [
        'One on one with grandma is always special.',
        'You get to know her better and she get to know you.',
        'Listen to the stories!',
        'Grandma feels special.'
      ],
      score: 25),
  Activity(
      id: 'm3',
      categories: [
        'c3',
      ],
      title: 'Shop For Grandma',
      urgency: Urgency.High,
      imageUrl:
          'https://www.tasteofhome.com/wp-content/uploads/2018/07/shutterstock_371623984.jpg?resize=700,700',
      duration: 75,
      requierd: [
        'Schedule with grandma.',
        'Go to the store / Order online.',
        'Ask grandma what she needs.',
        'Make sure that the shopping arrives safely.',
        'Help grandma sort out all the stuff.',
      ],
      importance: [
        'It is very hard for grandma to do shopping alone.',
        'Grandma needs food in her house.',
        'It is a big mitzva!',
      ],
      score: 30),
// each time we want to add Activity the id will be higher in 1.
// example - if the previous id was m3 than the next Acyivity will be m4.
// same with category.
];
