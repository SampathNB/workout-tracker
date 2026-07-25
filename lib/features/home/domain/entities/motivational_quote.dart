/// A short line of training motivation shown on the dashboard.
class MotivationalQuote {
  const MotivationalQuote({
    required this.text,
    required this.author,
  });

  final String text;
  final String author;
}

/// Curated quotes cycled by day-of-year so the dashboard feels fresh daily.
abstract final class MotivationalQuotes {
  static const List<MotivationalQuote> all = [
    MotivationalQuote(
      text: 'The only bad workout is the one that didn’t happen.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'Discipline is choosing between what you want now and what you want most.',
      author: 'Abraham Lincoln',
    ),
    MotivationalQuote(
      text: 'Success is the sum of small efforts repeated day in and day out.',
      author: 'Robert Collier',
    ),
    MotivationalQuote(
      text: 'You don’t have to be extreme, just consistent.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'The body achieves what the mind believes.',
      author: 'Napoleon Hill',
    ),
    MotivationalQuote(
      text: 'Sweat is fat crying.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'It never gets easier — you just get stronger.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'Motivation gets you going. Habit keeps you growing.',
      author: 'Jim Rohn',
    ),
    MotivationalQuote(
      text: 'Train like you deserve the results you want.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'Don’t limit your challenges. Challenge your limits.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'Strength does not come from the body. It comes from the will.',
      author: 'Gandhi',
    ),
    MotivationalQuote(
      text: 'Push yourself, because no one else is going to do it for you.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'The pain you feel today will be the strength you feel tomorrow.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'Be stronger than your excuses.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'A year from now you’ll wish you had started today.',
      author: 'Karen Lamb',
    ),
    MotivationalQuote(
      text: 'Champions keep playing until they get it right.',
      author: 'Billie Jean King',
    ),
    MotivationalQuote(
      text: 'Your body can stand almost anything. It’s your mind you have to convince.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'Make yourself proud.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'Slow progress is still progress.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'The hard days are what make you stronger.',
      author: 'Aly Raisman',
    ),
    MotivationalQuote(
      text: 'Excuses don’t burn calories.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'Fall in love with taking care of yourself.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'What seems impossible today will one day become your warm-up.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'You are one workout away from a good mood.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'Consistency beats intensity when intensity isn’t consistent.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'Do something today that your future self will thank you for.',
      author: 'Sean Patrick Flanery',
    ),
    MotivationalQuote(
      text: 'Rome wasn’t built in a day, but they worked on it every single day.',
      author: 'Unknown',
    ),
    MotivationalQuote(
      text: 'The secret of getting ahead is getting started.',
      author: 'Mark Twain',
    ),
    MotivationalQuote(
      text: 'Whether you think you can or you think you can’t, you’re right.',
      author: 'Henry Ford',
    ),
    MotivationalQuote(
      text: 'Energy and persistence conquer all things.',
      author: 'Benjamin Franklin',
    ),
    MotivationalQuote(
      text: 'Strive for progress, not perfection.',
      author: 'Unknown',
    ),
  ];

  /// Picks a stable quote for [date] (same quote all day).
  static MotivationalQuote forDate(DateTime date) {
    final dayOfYear = date.difference(DateTime(date.year)).inDays;
    return all[dayOfYear % all.length];
  }
}
