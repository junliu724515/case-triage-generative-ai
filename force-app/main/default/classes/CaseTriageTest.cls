/**
 * Created by junliu on 4/06/2024.
 */

@IsTest(SeeAllData=true)
public class CaseTriageTest {
    @IsTest static void testCaseTriage() {
        // Prepare test data
        Case testCase = new Case(Subject = 'Test Case', Description = 'Test Description');
        insert testCase;

        List<String> caseIds = new List<String>{
                testCase.Id
        };

        // Call the method to test
        List<CaseTriage.TriageResponse> responses = CaseTriage.caseTriage(caseIds);

        // Assert the results
        System.assertEquals(1, responses.size(), 'The number of responses should match the number of case IDs');
        for (CaseTriage.TriageResponse response : responses) {
            System.assertNotEquals(null, response.category, 'Category should not be null');
            System.assertNotEquals(null, response.summary, 'Summary should not be null');
            System.assertNotEquals(null, response.tone, 'Tone should not be null');
            System.assertNotEquals(null, response.repeating, 'Repeating should not be null');
        }
    }
}