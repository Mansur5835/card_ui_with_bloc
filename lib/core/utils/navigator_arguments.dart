class Args<Object> {
  Object? arguments;
  Args(this.arguments);

  Object? get get => arguments;

  set set(Object? arguments) {
    this.arguments = arguments;
  }
}
