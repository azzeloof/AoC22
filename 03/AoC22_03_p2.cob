      * PLS WORK
       IDENTIFICATION DIVISION.
       PROGRAM-ID. AoC22_03_p1.

       ENVIRONMENT DIVISION.
           INPUT-OUTPUT SECTION. 
               FILE-CONTROL.
               SELECT DATAFILE ASSIGN TO 'input.txt'
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
           FILE SECTION.
           FD DATAFILE.
           01 RUCKSACK-LINE.
               02 CONTENTS PIC A(48).

           WORKING-STORAGE SECTION.
           01 WS-RUCKSACKS OCCURS 300 TIMES.
               02 WS-CONTENTS PIC A(48).
      *         02 WS-LEN PIC 99.
      *         02 WS-PLEN PIC 99.
      *         02 WS-POC1 PIC A(24).
      *         02 WS-POC2 PIC A(24).
      *         02 WS-COM PIC A(1).
      *         02 WS-RORD PIC 999.
      *         02 WS-PRI PIC 99.
           01 WS-EOF PIC A(1).
           01 WS-CNT PIC 99.
           01 WS-MATCH PIC 9.
           01 WS-TOTAL PIC 9999.
           01 WS-NSACKS PIC 999.
           01 WS-SC PIC 999.
           01 WS-LEN PIC 99.
           01 WS-T1 PIC A(48).
           01 WS-T2 PIC A(48).
           01 WS-T3 PIC A(48).
           01 WS-M2 PIC 9.
           01 WS-M3 PIC 9.
           01 WS-COM PIC A(1).
           01 WS-RORD PIC 999.
           01 WS-PRI PIC 99.
      

       PROCEDURE DIVISION.
           OPEN INPUT DATAFILE.
              PERFORM UNTIL WS-EOF='Y'
                  READ DATAFILE
                      AT END MOVE 'Y' TO WS-EOF
                      NOT AT END
                           ADD 1 TO WS-NSACKS
                           MOVE RUCKSACK-LINE TO WS-RUCKSACKS(WS-NSACKS)
                  END-READ
              END-PERFORM.

              PERFORM VARYING WS-SC FROM 1 BY 3 UNTIL WS-SC > WS-NSACKS 
                   MOVE WS-CONTENTS(WS-SC) TO WS-T1
                   MOVE WS-CONTENTS(WS-SC + 1) TO WS-T2
                   MOVE WS-CONTENTS(WS-SC + 2) TO WS-T3
                   DISPLAY WS-T1
                   DISPLAY WS-T2
                   DISPLAY WS-T3
                   DISPLAY " "
                   MOVE 0 TO WS-LEN
                   INSPECT FUNCTION REVERSE(WS-T1)
      -                TALLYING WS-LEN FOR LEADING SPACES
                   COMPUTE WS-LEN = LENGTH OF WS-T1 - WS-LEN
                   PERFORM VARYING WS-CNT FROM 1 BY 1 UNTIL
                       WS-CNT > WS-LEN
                       SET WS-M2 TO 0
                       SET WS-M3 TO 0
                       INSPECT WS-T2 TALLYING WS-M2
                           FOR ALL WS-T1(WS-CNT:1)
                       INSPECT WS-T3 TALLYING WS-M3
                           FOR ALL WS-T1(WS-CNT:1)
                       IF WS-M2 > 0 THEN
                           IF WS-M3 > 0 THEN
                               MOVE WS-T1(WS-CNT:1) TO WS-COM
                               DISPLAY WS-COM
                              END-IF
                       END-IF
                   END-PERFORM
                   SET WS-RORD TO FUNCTION ORD(WS-COM)
                       IF WS-RORD>97 THEN 
                           SUBTRACT 97 FROM WS-RORD GIVING WS-PRI
                       ELSE
                           SUBTRACT 39 FROM WS-RORD GIVING WS-PRI
                       END-IF
                   ADD WS-PRI TO WS-TOTAL
              END-PERFORM.
      *                     INSPECT FUNCTION REVERSE (WS-CONTENTS) 
      *-                        TALLYING WS-LEN FOR LEADING SPACES
      *                     COMPUTE WS-LEN = LENGTH OF WS-CONTENTS 
      *-                         - WS-LEN
      *                     DIVIDE 2 INTO WS-LEN GIVING WS-PLEN
      *                     MOVE WS-CONTENTS(1:WS-PLEN) TO WS-POC1
      *                     MOVE WS-CONTENTS(WS-PLEN + 1 :WS-PLEN)
      *-                        TO WS-POC2
      *                     SET WS-CNT TO 0
      *                     PERFORM UNTIL WS-CNT > WS-PLEN
      *                         SET WS-MATCH TO 0
      *                         INSPECT WS-POC2 TALLYING WS-MATCH
      *                             FOR ALL WS-POC1(WS-CNT:1)
      *                         IF WS-MATCH>0 THEN
      *                             MOVE WS-POC1(WS-CNT:1) TO WS-COM
      *                             SET WS-RORD TO FUNCTION ORD(WS-COM)
      *                             IF WS-RORD>97 THEN 
      *                                 SUBTRACT 97 FROM
      *                                     WS-RORD GIVING WS-PRI
      *                             ELSE
      *                                 SUBTRACT 39 FROM
      *                                     WS-RORD GIVING WS-PRI
      *                             END-IF
      *                             ADD WS-PRI TO WS-TOTAL
      *                             ADD 1 TO WS-PLEN GIVING WS-CNT
      *                         ELSE
      *                             ADD 1 TO WS-CNT
      *                         END-IF
      *                     END-PERFORM
           CLOSE DATAFILE.
           DISPLAY WS-TOTAL.
           STOP RUN.
           