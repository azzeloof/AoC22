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
           01 WS-RUCKSACKS.
               02 WS-CONTENTS PIC A(48).
               02 WS-LEN PIC 99.
               02 WS-PLEN PIC 99.
               02 WS-POC1 PIC A(24).
               02 WS-POC2 PIC A(24).
               02 WS-COM PIC A(1).
               02 WS-RORD PIC 999.
               02 WS-PRI PIC 99.
           01 WS-EOF PIC A(1).
           01 WS-CNT PIC 99.
           01 WS-MATCH PIC 9.
           01 WS-TOTAL PIC 9999.

       PROCEDURE DIVISION.
           OPEN INPUT DATAFILE.
              PERFORM UNTIL WS-EOF='Y'
                  READ DATAFILE INTO WS-RUCKSACKS
                      AT END MOVE 'Y' TO WS-EOF
                      NOT AT END
                           DISPLAY WS-CONTENTS
                           INSPECT FUNCTION REVERSE (WS-CONTENTS) 
      -                        TALLYING WS-LEN FOR LEADING SPACES
                           COMPUTE WS-LEN = LENGTH OF WS-CONTENTS 
      -                         - WS-LEN
                           DIVIDE 2 INTO WS-LEN GIVING WS-PLEN
                           MOVE WS-CONTENTS(1:WS-PLEN) TO WS-POC1
                           MOVE WS-CONTENTS(WS-PLEN + 1 :WS-PLEN)
      -                        TO WS-POC2
                           SET WS-CNT TO 0
                           PERFORM UNTIL WS-CNT > WS-PLEN
                               SET WS-MATCH TO 0
                               INSPECT WS-POC2 TALLYING WS-MATCH
                                   FOR ALL WS-POC1(WS-CNT:1)
                               IF WS-MATCH>0 THEN
                                   MOVE WS-POC1(WS-CNT:1) TO WS-COM
                                   SET WS-RORD TO FUNCTION ORD(WS-COM)
                                   IF WS-RORD>97 THEN 
                                       SUBTRACT 97 FROM
                                           WS-RORD GIVING WS-PRI
                                   ELSE
                                       SUBTRACT 39 FROM
                                           WS-RORD GIVING WS-PRI
                                   END-IF
                                   ADD WS-PRI TO WS-TOTAL
                                   ADD 1 TO WS-PLEN GIVING WS-CNT
                               ELSE
                                   ADD 1 TO WS-CNT
                               END-IF
                           END-PERFORM
                 END-READ
              END-PERFORM.
           CLOSE DATAFILE.
           DISPLAY WS-TOTAL.
           STOP RUN.
           