# Text in color
A package to colorize the text by regular expression.


# Usage
## Highlight the target text
You will pass a `Map<String, ColorizeTextAction>` to the `map` parameter, the `key` is the target text you want to color, and the `value` will be the properties of that text.

See example below:

```dart  
  Widget myColorizeText() {
    return ColorizeText(
      'This is @blue and this is @red',
      map: {
        '@blue': TextFormatInfo(
            onPressed: (value) {
              print(value); //print '@red'
            },
            alternativeText: 'blue',
            textStyle: TextStyle(color: Colors.blueAccent)),
        '@red': TextFormatInfo(
            onPressed: (value) {
              print(value); //print '@blue'
            },
            alternativeText: 'red',
            textStyle: TextStyle(color: Colors.redAccent))
      },
      textStyle: TextStyle(color: Colors.black),
    );
  }
```

And this should be the result: <br/>

![alt text](https://i.imgur.com/cOBUepcl.png)

## Highlight the text by regular expression
Besides selecting a destination text, you can also pass into `key` a regular expression.

See example below:

```dart
  Widget myColorizeRegex() {
    return ColorizeText(
      'This is https://www.google.com and a@gmail.com and 9',
      map: {
        r'''(?:http(s)?:\/\/)?[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+''':
            TextFormatInfo(
                onPressed: (value) {
                  print(value); //print 'https://www.google.com'
                },
                alternativeText: 'link regex',
                textStyle: TextStyle(color: Colors.purpleAccent)),
        r"[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$": TextFormatInfo(
            onPressed: (value) {
              print(value); //print 'a@gmail.com'
            },
            alternativeText: 'email regex',
            textStyle: TextStyle(color: Colors.lightBlueAccent)),
        r"[0-9]": TextFormatInfo(
            onPressed: (value) {
              print(value); //print '9'
            },
            alternativeText: 'number regex',
            textStyle: TextStyle(color: Colors.orangeAccent))
      },
      textStyle: TextStyle(color: Colors.black),
    );
  }
  ```
And this should be the result: <br/>

![alt text](https://i.imgur.com/BhVDiZ7l.png)

## Highlight the text and process the data contained within it
You can also handle generic data by passing into the `data` parameter.

```dart
class TextFormatInfo<T> {
  final TextStyle textStyle;
  final Function(T) onPressed;
  final String alternativeText;
  final T data;

  TextFormatInfo(
      {this.textStyle, this.onPressed, this.alternativeText, this.data});
}
```

The `onPressed` function will return a generic type depending on the type of the `data` parameter.

See example below:<br/>
I create a list of 10 users, each user will have two properties: `id` and` name`
```dart
class User {
  final String id;
  final String name;

  User({this.id, this.name});
}

```

```dart
  final List<User> userList = List.generate(
      10, (index) => User(id: index.toString(), name: 'User $index'));
```



