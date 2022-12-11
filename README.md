# nursing_home_dexter

Dexter Project

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


Dexter health assignment explanation

User credentials:
Email :new@test.com
Password : Ahly1907
—
Please note that signup is also implemented and works fine. However if  you decide to try this path as well.
I would require you to inform me of your email to fetch the userid of the new user and add shifts for him.
I will explain briefly the structure.
—

Collections:
ShiftTypes: holds data of each shift with id, title, start time, and end time.

Users( which handles nurse’s name, pendingTasks,completedTasks).

Residents( collection which holds name of resident, tasks required for the patient, and shiftTypes array of string that holds ids of all shiftTypes required for this patient. ( this is implemented to be able to filter later by shift type).

Shifts( holds data of shift, type of shift( reference for shiftTypes), and nurseID) this way we can filter on adding tasks for each nurse by selecting dropdown. N.B.the idea of this as nurses are not the ones that choose when they work in shift, its set by hospital administration so when they try to add an action/task they will be able to select from their current shift or future shifts for them

Tasks ( each task has nurseID,state,taskTitle,timestamp, resdienceID and name) this way we can filter by residents and know what tasks are left for residents or for nurses).


For instance by filtering tasks with nurseID and state, I fetch all pending tasks for nurses with date less than today(neglecting time) and then move its date to today.
—


