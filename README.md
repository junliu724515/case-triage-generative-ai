Instructions to deploy the sample app


# Case Classification and Routing using Salesforce Generative AI, Apex, and Flow

## Description

With the new Generative AI and prompt builder on the platform, leveraging LLMs on Salesforce has become easier and more accessible. This project demonstrates how to use the new AI capabilities to classify and route cases in Salesforce.

## Installation

1. Turn on Einstein in your org

   Click the Setup icon and select Setup.
   This will take you to the Setup page for your org
   In the Quick Find, type Einstein Setup then select Einstein Setup.
   Toggle the Turn on Einstein switch.


2. Clone the repository:

```bash
git clone https://github.com/junliu724515/case-triage-generative-ai.git

```

3. Navigate to the project directory:

```bash
cd case-triage-generative-ai
```

4. Deploy the project to your Salesforce org:

```bash
sf project deploy start  --target-org yourOrgAlias
```

## High Level Flow
![High level flow](./images/high-level-flow.png)

## Prompt Sample
![Prompt Sample](./images/prompt.png)

## Case Record Fields
![Case Record Fields](./images/case-record-fields.png)

## License

[MIT](https://choosealicense.com/licenses/mit/)
```
