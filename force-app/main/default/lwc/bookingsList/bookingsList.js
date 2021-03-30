import { LightningElement, api, wire } from 'lwc';
import getJetList from '@salesforce/apex/JetExp.getJetBookingList';

const columns = [
    { label: 'Booking Name', fieldName: 'Name' },
    { label: 'Status', fieldName: 'Status__c' },
];

export default class BookingsList extends LightningElement {
    jet;
    _jetId = undefined;
    @wire(getJetList)
    bookings;
    data = [];
    columns = columns;

    // Use set and get to process the value every time it's
    // requested while switching between products
    set jetId(value) {
        this._jetId = value;
        // this.jet = bikes.find(bike => bike.fields.Id.value === value);
    }
    
    // getter for jetId
    @api get jetId(){
        return this._jetId;
    }
}