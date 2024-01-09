// String example is: "business-english,conversational-english,english-for-kids,ielts"
// split at comma, replace dash with space, capitalize each word
List<String> formatTagsCard(String tags) {
  List<String> plaintags =
      tags.split(',').map((e) => e.replaceAll('-', ' ')).toList();
  // if it's a single word (doesn't have space character) and less than 8 characters, toUpperCase
  List<String> formattedTags = plaintags
      .map((e) => e.length < 8 && !e.contains(' ')
          ? e.toUpperCase()
          : capitalizeWords(e))
      .toList();
  return formattedTags;
}

String capitalizeWords(String s) =>
    s.split(' ').map((str) => capitalize(str)).join(' ');

String capitalize(String s) =>
    s.isNotEmpty ? s[0].toUpperCase() + s.substring(1) : "";
