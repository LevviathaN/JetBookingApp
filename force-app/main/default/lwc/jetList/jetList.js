import { LightningElement, api, wire } from 'lwc';
import getJetList from '@salesforce/apex/JetExp.getJetList';
import JET_OBJECT from '@salesforce/schema/Jet__c';
import NAME_FIELD from '@salesforce/schema/Jet__c.Name';
import STATUS_FIELD from '@salesforce/schema/Jet__c.Status__c';
import MILAGE_FIELD from '@salesforce/schema/Jet__c.Current_Milage__c';
import DETAILS_FIELD from '@salesforce/schema/Jet__c.Details__c';

const columns = [
    { label: 'Model Name', fieldName: 'Name' },
    { label: 'Status', fieldName: 'Status__c' },
    { label: 'Current Milage', fieldName: 'Current_Milage__c' },
    { label: 'Details', fieldName: 'Details__c' },
    {type: 'button-icon', typeAttributes: {  
        iconName: 'utility:download',
        label: 'Download',  
        name: 'download',  
        variant: 'bare',
        alternativeText: 'download',        
        disabled: false
    }}
];

// const fields = [NAME_FIELD, STATUS_FIELD, MILAGE_FIELD, DETAILS_FIELD];

export default class JetList extends LightningElement {

    @wire(getJetList)
    jets;

    //data = [];
    columns = columns;

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        const evt = new CustomEvent('jetselected', {
            // detail contains only primitives
            detail: row.fields.Id.value
        });
        switch (actionName) {
            case 'download':
                this.dispatchEvent(evt);
                break;                      
            default:
        }
    }

    //@api recordId;

    // @wire(getRecord, { recordId: '$recordId', fields: fields })
    // jet;

    // get name() {
    //     return getFieldValue(this.jet.data, NAME_FIELD);
    // }

    // get status() {
    //     return getFieldValue(this.jet.data, STATUS_FIELD);
    // }

    // get milage() {
    //     return getFieldValue(this.jet.data, MILAGE_FIELD);
    // }

    // get details() {
    //     return getFieldValue(this.jet.data, DETAILS_FIELD);
    // }

    // // eslint-disable-next-line @lwc/lwc/no-async-await
    // async connectedCallback() {
    //     const data = await fetchDataHelper({ amountOfRecords: 100 });
    //     this.data = data;
    // }
}


