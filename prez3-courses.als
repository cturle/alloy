open util/relation

abstract sig Course
{
	dpt: Department
}

sig Introductory extends Course
{
}

sig Advanced extends Course
{
	prerequisites: some Course
}
fact
{
	acyclic[prerequisites, Course]
  no prerequisites.^prerequisites & prerequisites
}

sig Elective in Course
{
}

sig Student
{
	major_dpt: lone Department,
	taken: set Course
}
{
	all T: taken | all_prereq[T] in taken
}

sig Freshman extends Student
{
}

sig Sophomore extends Student
{
}

sig Junior extends Student
{
}

sig Senior extends Student
{
}

sig Department
{
  all_courses: set Course,
	required_courses: set Course,
  optional_courses: set Course
}
{
  required_courses in all_courses
  optional_courses = all_courses - required_courses
}

assert A1
{
	all A: Advanced | some I: Introductory | I in A.^prerequisites
}
check A1

fun all_prereq[Cs: set Course] : set Course
{
	Cs.^prerequisites
}
run all_prereq

pred can_take_course[S: Student, C: Course]
{
	not C in S.taken
  all_prereq[C] in S.taken
}
run can_take_course

pred can_graduate[S: Student]
{
	S in Senior
  one S.major_dpt
  S.major_dpt.required_courses in S.taken
  some S.taken & Elective
}
run can_graduate


run {}


















