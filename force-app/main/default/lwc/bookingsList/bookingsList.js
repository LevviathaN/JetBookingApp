import { LightningElement, api, wire } from 'lwc';
import getJetBookingList from '@salesforce/apex/JetExp.getJetBookingList';
import JET_BOOKING_OBJECT from '@salesforce/schema/Jet_Booking__c';

const columns = [
    { label: 'Booking Name', fieldName: 'Name' },
    { label: 'Status', fieldName: 'Status__c' },
];

export default class BookingsList extends LightningElement {
    @api _jetId = 'a033N000003ipmcQAA';
    @wire(getJetBookingList, { jetId: '$_jetId' })
    bookings;
    columns = columns;

    // Use set and get to process the value every time it's
    // requested while switching between products
    set jetId(value) {
        this._jetId = value;
        //this.selected = bookings.find(bookings => bookings.fields.Id.value === value);
    }
    
    // getter for jetId
    @api get jetId(){
        return this._jetId;
    }
}