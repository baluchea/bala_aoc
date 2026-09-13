@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Supplement child entity'
@Metadata.ignorePropagatedAnnotations: true
define view entity zats_ab_booksuppl as select from /dmo/booksuppl_m
association to parent zats_ab_booking as _Booking
    on $projection.TravelId = _Booking.TravelId and 
       $projection.BookingId = _Booking.BookingId
association[1..1] to zats_ab_travel1 as _Travel
    on $projection.TravelId = _Travel.TravelId  
association[1..1] to /DMO/I_Supplement as _Supplement
    on $projection.SupplementId = _Supplement.SupplementID 
association[1..*] to /DMO/I_SupplementText as _SupplementText
    on $projection.SupplementId = _SupplementText.SupplementID 
{
    key /dmo/booksuppl_m.travel_id as TravelId,
    key /dmo/booksuppl_m.booking_id as BookingId,
    @Consumption.valueHelpDefinition: [{  
                    entity:{
                    name: '/DMO/I_Supplement',
                    element: 'SupplementID'
                    }
                    }]
    key /dmo/booksuppl_m.booking_supplement_id as BookingSupplementId,
    /dmo/booksuppl_m.supplement_id as SupplementId,
    @Consumption.valueHelpDefinition: [{  
                    entity:{
                    name: 'I_Currency',
                    element: 'Currency'
                    }
                    }]
    @Semantics.amount.currencyCode: 'CurrencyCode'
    /dmo/booksuppl_m.price as Price,
    /dmo/booksuppl_m.currency_code as CurrencyCode,
    @Semantics.systemDateTime.lastChangedAt: true
    /dmo/booksuppl_m.last_changed_at as LastChangedAt,
    
    _Booking, // Make association public
    _Travel,
    _Supplement,
    _SupplementText
}
