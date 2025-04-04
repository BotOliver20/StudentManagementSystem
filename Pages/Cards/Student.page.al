page 50004 "StudentPage"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = StudentTable;
    AutoSplitKey = True;
    DelayedInsert = true;
    InsertAllowed = true;
    ModifyAllowed = true;
    SaveValues = true;
    


    layout
    {
        area(Content)
        {
            repeater(Student)
            {
                field("Student ID"; Rec.StudentID)
                {
                    ApplicationArea = All;
                    ToolTip = 'The student number';
                    Editable = false;

                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::StudentPage2, Rec);
                    end;

                    trigger OnValidate()
                    begin
                        if (Rec.StudentID) < 1 then
                            Error('Student ID must be between 1 and 100');
                        if (Rec.StudentID) > 100 then
                            Error('Student ID must be between 1 and 100');

                    end;
                }
                field("Name"; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'The first name of the student';
                }

                field("Surname"; Rec.Surname)
                {
                    ApplicationArea = All;
                    ToolTip = 'The last name of the student';

                }
                field("Date of Birth"; Rec.DateOfBirth)
                {
                    ApplicationArea = All;
                    ToolTip = 'The date of birth of the student';
                }
                field("Sex"; Rec.Sex)
                {
                    ApplicationArea = All;
                }
                field("Phone No"; Rec."Phone No")
                {
                    ApplicationArea = All;
                    ToolTip = 'The phone number of the student';
                }
                field("Email"; Rec.Email)
                {
                    ApplicationArea = All;
                    ToolTip = 'The email address of the student';
                }
                field("Address"; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'The address of the student';
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'The registration date of the student';
                }
                field("Status"; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Average"; Rec.Average)
                {
                    ApplicationArea = All;
                    ToolTip = 'The average grade of the student';
                    trigger OnValidate()
                    begin
                        Avarage.Average();
                    end;
                }
                
            }
        }
    }

    actions

    {
        area(Promoted)
        {
            actionref(MyPromotedActionRef; "More Details")
            {

            }
            actionref(MyOtherPromotedActionRef; "Delete")
            {

            }
            actionref(GetCheckStatus; "CheckStatus")
            {

            }
            group(Options)
            {
                actionref(GetViewGrades; "ViewGrades")
                {

                }
                actionref(GetSave; "Save")
                {

                }
                actionref(GetCancel; "Cancel")
                {

                }
                actionref(GetPrintStudentReport; "PrintStudentReport")
                {

                }
                actionref(GetSendAMessage; "Send a Message")
                {

                }
                actionref(GetImportData; "Import Data")
                {

                }

            }
        }


        area(Processing)
        {


            // action("Save")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Save';
            //     Image = Save;
            //     trigger OnAction()
            //     begin
            //         PAGE.RUN(PAGE::"GradePage", Rec);
            //     end;
            // }
            // action("Cancel")
            // {
            //     Caption = 'Cancel';
            //     Image = Cancel;
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     begin
            //         CurrPage.Close();
            //     end;
            // }

            // action("PrintStudentReport")
            // {
            //     Caption = 'Print Student Report';
            //     Image = Print;
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     var
            //         StudentReport: Report "StudentReport";
            //     begin
            //         StudentReport.SetTableView(Rec);
            //         StudentReport.RunModal();
            //     end;
            // }

            // action("Import Data")
            // {
            //     Caption = 'Import Data';
            //     Image = Import;
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     begin
            //         ImportExelCodeunit.ReadExelSheet();
            //         ImportExelCodeunit.InsertExelData();
            //     end;
            // }
            // action("Send a Message")
            // {
            //     Caption = 'Send a Message';
            //     Image = Email;
            //     ApplicationArea = All;
            //     trigger OnAction()
            //     begin
            //         MESSAGE('Eshte vetem nje test');
            //     end;
            // }



        }
        area(Navigation)
        {
            action(TopStudent)
            {
                ApplicationArea = All;
                trigger OnAction()
                begin
                    GetTopStudentByCourses.GetStudentWithMostCourses();
                end;
            }
            action("More Details")
            {
                Caption = 'More Details';
                ApplicationArea = All;
                Image = ViewDetails;


                trigger OnAction()
                begin
                    PAGE.RUN(PAGE::"StudentPage2", Rec);
                end;


            }
            action("Delete")
            {
                Caption = 'Delete';
                ApplicationArea = All;
                Image = Delete;


                trigger OnAction()
                begin
                    Rec.DELETE;
                    CurrPage.Update();
                end;
            }
            action("Save")
            {
                ApplicationArea = All;
                Caption = 'Save';
                Image = Save;
                trigger OnAction()
                begin
                    PAGE.RUN(PAGE::"GradePage", Rec);
                end;
            }
            action("Cancel")
            {
                Caption = 'Cancel';
                Image = Cancel;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }

            action("ViewGrades")
            {
                Caption = 'View Grades';
                Image = ShowChart;
                ApplicationArea = All;
                trigger OnAction()
                var
                    GradePageRec: Record GradeTable;
                begin
                    GradePageRec.SetRange(StudentId, Rec.StudentID);
                    PAGE.RUNMODAL(PAGE::"GradePage", GradePageRec);
                end;
            }
            action("PrintStudentReport")
            {
                Caption = 'Print Student Report';
                Image = Print;
                ApplicationArea = All;
                trigger OnAction()
                var
                    StudentReport: Report "StudentReport";
                begin
                    StudentReport.SetTableView(Rec);
                    StudentReport.RunModal();
                end;
            }
            action("Import Data")
            {
                Caption = 'Import Data';
                Image = Import;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    ImportExelCodeunit.ReadExelSheet();
                    ImportExelCodeunit.InsertExelData();
                end;
            }
            action("Send a Message")
            {
                Caption = 'Send a Message';
                Image = Email;
                ApplicationArea = All;
                trigger OnAction()
                begin
                    MESSAGE('Eshte vetem nje test');
                end;
            }
            action("CheckStatus")
            {
                Caption = 'Check Status';
                Image = Info;
                ApplicationArea = All;
                // trigger OnAction()
                // var
                //     RegRec: Record "RegistrationTable";
                //     PaymentRec: Record "PaymentTable";
                //     StatusMessage: Text[250];
                // begin


                //     RegRec.SETRANGE(StudentID, Rec.StudentID);
                //     RegRec.SETRANGE(PaymentStatus, RegRec.PaymentStatus);
                //     if RegRec.FindFirst then begin

                //         PaymentRec.SETRANGE(StudentID, Rec.StudentID);
                //         PaymentRec.SETRANGE(Status, PaymentRec.Status);
                //         if PaymentRec.FindFirst then
                //             StatusMessage := 'The student has an active course and payment is completed.'
                //         else
                //             StatusMessage := 'The student has an active course, but payment is not completed.';
                //     end else begin
                //         StatusMessage := 'The student does not have an active course.';
                //     end;
                //     MESSAGE(StatusMessage);
                // end;
            }


        }
    }

    var
        ImportExelCodeunit: Codeunit "ImportExelCodeunit";
        Avarage: Codeunit StudentAverage;
        GetTopStudentByCourses: Codeunit StudentCourseAnalysis;
}

