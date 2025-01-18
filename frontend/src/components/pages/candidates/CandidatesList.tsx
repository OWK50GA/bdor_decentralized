import { dummyPlayers } from "@/lib/data";
import Image from "next/image";
import GenericImage from '../../../../public/actual-bdor-image.png'
import Link from "next/link";
import CandidateCard from "./CandidateCard";

const CandidatesList = () => {

    const candidates = dummyPlayers
    return ( 
        <div className="flex flex-col gap-10 mt-10 border shadow-white w-11/12 mx-auto py-4 px-4">
            <h2 className="text-center text-4xl text-gold-500 font-bold">Leading Candidates</h2>

            <div className="flex flex-wrap w-10/12 mx-auto justify-between gap-y-12 gap-x-2">
                {
                    candidates && candidates.map((candidate, index) => {
                        return (
                            <CandidateCard 
                                key={index} 
                                rank={candidate.rank} 
                                noOfVotes={candidate.noOfVotes} 
                                name={candidate.name}
                                club={candidate.club}
                            />
                        )
                    })
                }
            </div>
            <div className="flex w-full justify-end">
                <button className="border border-white px-4 py-2 rounded-lg hover:border-gold-500 hover:text-gold-500 hover:shadow-gold-hover">
                    <Link href={''}>
                        View all &rsaquo;
                    </Link>
                </button>
            </div>
        </div>
    );
}
 
export default CandidatesList;