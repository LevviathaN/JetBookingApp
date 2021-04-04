import { LightningElement, api } from 'lwc';
import BOOKING_OBJECT from '@salesforce/schema/Jet_Booking__c';
import NAME_FIELD from '@salesforce/schema/Jet_Booking__c.Name';
import JET_FIELD from '@salesforce/schema/Jet_Booking__c.Jet__c';
import CUSTOMER_FIELD from '@salesforce/schema/Jet_Booking__c.Customer__c';
import DEPARTURE_FIELD from '@salesforce/schema/Jet_Booking__c.Departure_Airport__c';
import ARIVAL_FIELD from '@salesforce/schema/Jet_Booking__c.Arival_Airport__c';

export default class BookingCrud extends LightningElement {
    clickedButtonLabel;
    create = false;
    update = false;

    selectedFields = [JET_FIELD, CUSTOMER_FIELD, DEPARTURE_FIELD, ARIVAL_FIELD];

    bookingObject = BOOKING_OBJECT;
    jetField = JET_FIELD;
    customerField = CUSTOMER_FIELD;
    departureAirportField = DEPARTURE_FIELD;
    arivalAirportField = ARIVAL_FIELD;

    @api bookingId = 'a023N000005EHXUQA4';
    name = '';

    handleNameChange(event) {

    }

    handleAccountCreated(){
        // Run code when account is created.
    }

    handleClick(event) {
        this.clickedButtonLabel = event.target.label;
    }

    handleCreateClick(event) {
        this.create = true;
        this.update = false;
    }

    handleUpdateClick(event) {
        this.create = false;
        this.update = true;
    }

    handleCreateBookingClick(event) {
        // const fields = {};
        // fields[NAME_FIELD.fieldApiName] = this.name;
        // const recordInput = { apiName: BOOKING_OBJECT.objectApiName, fields };
        // createRecord(recordInput)
        //     .then(account => {
        //         this.accountId = account.id;
        //         this.dispatchEvent(
        //             new ShowToastEvent({
        //                 title: 'Success',
        //                 message: 'Account created',
        //                 variant: 'success',
        //             }),
        //         );
        //     })
        //     .catch(error => {
        //         this.dispatchEvent(
        //             new ShowToastEvent({
        //                 title: 'Error creating record',
        //                 message: error.body.message,
        //                 variant: 'error',
        //             }),
        //         );
        //     });
    }
}