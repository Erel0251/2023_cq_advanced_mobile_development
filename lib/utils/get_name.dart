String getName(String fullname) {
  return fullname.split(' ').map((e) => e[0]).join();
}
