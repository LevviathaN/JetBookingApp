import { LightningElement, api, wire } from 'lwc';
import getJetList from '@salesforce/apex/JetExp.getJetList';
import JET_OBJECT from '@salesforce/schema/Jet__c';
import NAME_FIELD from '@salesforce/schema/Jet__c.Name';
import STATUS_FIELD from '@salesforce/schema/Jet__c.Status__c';
import MILAGE_FIELD from '@salesforce/schema/Jet__c.Current_Milage__c';
import DETAILS_FIELD from '@salesforce/schema/Jet__c.Details__c';

const actions = [
    { label: 'Show details', name: 'show_details' }
];

const columns = [
    { label: 'Model Name', fieldName: 'Name' },
    { label: 'Status', fieldName: 'Status__c' },
    { label: 'Current Milage', fieldName: 'Current_Milage__c' },
    { label: 'Details', fieldName: 'Details__c' },
    {
        type: 'action',
        typeAttributes: { rowActions: actions },
    }
    // {type: 'button-icon', typeAttributes: {  
    //     iconName: 'utility:download',
    //     label: 'Download',  
    //     name: 'download',  
    //     variant: 'bare',
    //     alternativeText: 'download',        
    //     disabled: false.valueOf
    // }}
];

export default class JetList extends LightningElement {

    @wire(getJetList)
    jets;

    columns = columns;

    handleRowAction(event) {
        const actionName = event.detail.action.name;
        const row = event.detail.row;
        const evt = new CustomEvent('jetselected', {
            // detail contains only primitives
            detail: row.fields.Id.value
        });
        switch (actionName) {
            case 'show_details':
                this.dispatchEvent(evt);
                break;                      
            default:
        }
    }
}


