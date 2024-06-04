public with sharing class CaseTriage {

    @InvocableMethod(Label='Case Triage' Description='Call Prompt Template to triage cases.')
    public static List<TriageResponse> caseTriage(List<String> caseIds) {

        // Initialize a list to store the triage responses
        List<TriageResponse> triageResponses = new List<TriageResponse>();

        // Loop through each case ID
        for (String caseId : caseIds) {
            try {
                // Prepare the input for the prompt template
                ConnectApi.EinsteinPromptTemplateGenerationsInput promptGenerationsInput = new ConnectApi.EinsteinPromptTemplateGenerationsInput();
                Map<String, ConnectApi.WrappedValue> inputParams = new Map<String, ConnectApi.WrappedValue>();
                Map<String, String> caseInput = new Map<String, String>();

                // Add the case ID to the input
                caseInput.put('id', caseId);
                ConnectApi.WrappedValue caseValueMap = new ConnectApi.WrappedValue();
                caseValueMap.value = caseInput;
                inputParams.put('Input:Case', caseValueMap);

                // Set additional configuration for the prompt template
                promptGenerationsInput.inputParams = inputParams;
                promptGenerationsInput.additionalConfig = new ConnectApi.EinsteinLlmAdditionalConfigInput();
                promptGenerationsInput.additionalConfig.numGenerations = 1;
                promptGenerationsInput.additionalConfig.maxTokens = 4096;
                promptGenerationsInput.additionalConfig.model = 'gpt-4-turbo';
                promptGenerationsInput.additionalConfig.enablePiiMasking = false;
                promptGenerationsInput.additionalConfig.frequencyPenalty = 0.5;
                promptGenerationsInput.additionalConfig.presencePenalty = 0.5;
                promptGenerationsInput.additionalConfig.temperature = 0.5;
                promptGenerationsInput.additionalConfig.applicationName = 'PromptBuilderPreview';
                promptGenerationsInput.isPreview = false;

                // Generate messages for the prompt template
                ConnectApi.EinsteinPromptTemplateGenerationsRepresentation generationsOutput = ConnectApi.EinsteinLLM.generateMessagesForPromptTemplate('Case_Triage_Prompt', promptGenerationsInput);

                // Consume the response and add it to the list of triage responses
                ConnectApi.EinsteinLLMGenerationItemOutput response = generationsOutput.generations[0];
//                System.debug(response.text);
                triageResponses.add((TriageResponse) JSON.deserialize(response.text, TriageResponse.class));
            } catch (Exception e) {
                // Log any errors that occur during the triage process
                System.debug('Error during case triage: ' + e.getMessage());
            }
        }

        // Return the list of triage responses
        return triageResponses;
    }

    // Class to represent the response from the triage process
    public class TriageResponse {
        @InvocableVariable
        public String category;
        @InvocableVariable
        public String summary;
        @InvocableVariable
        public String tone;
        @InvocableVariable
        public Boolean repeating;
    }

}