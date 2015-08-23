# atomas_electron_microscope
Tool to probe how Atomas works

## Operation

### Gather data

`$ ruby electron_microscope.rb`

Enter the atoms in the outer ring
```
Enter atoms in ring, empty to continue...
1
1
2
3

```

Then enter the atoms that are spawned
```
Next atom:
2
Next atom:
1
```

Whenever atoms in the outer ring are changed or destroyed, enter an empty line to re-enter the outer ring again

When you're finished, just enter an empty line at the prompt to enter the outer ring

### Analyze Data
electron_microscope will save your data to atomas_data.txt. To analyze that data, run spectrograph.rb

`$ ruby spectrograph.rb`

## Sample Results

```
Average atomic mass: 2
  mass    frequency (%)
   1       50
   2       17
   3       33

Average atomic mass: 3
  mass    frequency (%)
   1       38
   2       28
   3       23
   4       10

Average atomic mass: 4
  mass    frequency (%)
   1       9
   2       43
   3       27
   4       20

Average atomic mass: 5
  mass    frequency (%)
   2       33
   3       26
   4       37
   5       4

Average atomic mass: 6
  mass    frequency (%)
   1       4
   3       35
   4       22
   5       17
   6       22

Average atomic mass: 7
  mass    frequency (%)
   2       7
   3       17
   4       31
   5       28
   6       7
   7       10

Average atomic mass: 8
  mass    frequency (%)
   3       6
   4       9
   5       23
   6       13
   7       23
   8       15
   9       11

Average atomic mass: 9
  mass    frequency (%)
   4       2
   5       13
   6       13
   7       30
   8       26
   9       17

Average atomic mass: 10
  mass    frequency (%)
   5       9
   6       9
   7       17
   8       30
   9       9
  10       17
  11       9

Average atomic mass: 11
  mass    frequency (%)
   7       5
   8       29
   9       24
  10       14
  11       19
  12       10

Average atomic mass: 12
  mass    frequency (%)
   8       16
   9       23
  10       13
  11       13
  12       23
  13       6
  14       3
  15       3

Average atomic mass: 13
  mass    frequency (%)
   9       12
  10       25
  11       24
  12       31
  13       8

Average atomic mass: 14
  mass    frequency (%)
   9       29
  10       24
  11       24
  12       18
  13       6

Average atomic mass: 15
  mass    frequency (%)
   9       5
  10       19
  11       14
  12       14
  13       5
  14       10
  15       5
  16       10
  17       10
  18       5
  19       5

Average atomic mass: 16
  mass    frequency (%)
  10       9
  11       27
  12       18
  13       18
  14       9
  15       9
  18       9

Average atomic mass: 17
  mass    frequency (%)
  11       27
  12       18
  13       36
  14       18

Average atomic mass: 18
  mass    frequency (%)
  10       50
  11       50

Average atomic mass: 19
  mass    frequency (%)
  15       20
  16       20
  18       10
  19       20
  20       10
  21       10
  22       10

Average atomic mass: 20
  mass    frequency (%)
  14       11
  15       37
  16       21
  17       5
  18       21
  19       5

Average atomic mass: 21
  mass    frequency (%)
  14       10
  15       14
  16       24
  17       5
  18       33
  19       14

Average atomic mass: 22
  mass    frequency (%)
  14       4
  15       4
  16       13
  17       17
  18       13
  19       17
  20       29
  21       4

Average atomic mass: 23
  mass    frequency (%)
  14       6
  16       6
  17       11
  18       17
  19       28
  20       11
  22       6
  23       11
  24       6

Average atomic mass: 24
  mass    frequency (%)
  17       14
  18       9
  19       9
  20       9
  21       32
  22       27

Average atomic mass: 25
  mass    frequency (%)
  12       3
  17       5
  20       15
  21       13
  22       28
  23       18
  25       15
  26       5

Average atomic mass: 26
  mass    frequency (%)
  17       7
  19       13
  20       7
  21       20
  22       7
  23       27
  24       20

Average atomic mass: 27
  mass    frequency (%)
  18       50
  24       50
```
